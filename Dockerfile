FROM ruby:3.2.2-alpine AS runtime

COPY . /usr/src
WORKDIR /usr/src
ENV HOME=/usr/src PATH=/usr/src/bin:$PATH

RUN apk add --no-cache ca-certificates curl less libpq openssl tzdata

RUN apk add --no-cache \
  build-base \
  git \
  postgresql-dev

# Development
FROM runtime AS development

COPY Gemfile* /usr/src/

RUN bundle install --jobs=4 --retry=3

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

FROM development AS builder

RUN bundle clean --force
RUN bundle install --jobs=4 --retry=3
RUN bundle config without development:test

FROM runtime AS release

ENV RAILS_ENV=production RACK_ENV=production PORT=3000

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder --chown=nobody:nogroup /usr/src /usr/src

CMD ["puma"]