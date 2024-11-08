FROM ruby:3.2.2-alpine AS runtime

COPY . /usr/src
WORKDIR /usr/src

RUN apk add --no-cache ca-certificates curl less libpq openssl tzdata

RUN apk add --no-cache \
  build-base \
  git \
  postgresql-dev

COPY Gemfile* /usr/src/

RUN bundle install --jobs=4 --retry=3

COPY bin/entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
