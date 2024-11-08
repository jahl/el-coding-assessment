# README

## Installation

1. Copy the project
```bash
git clone https://github.com/jahl/el-coding-assessment.git
```

2. Rename the file `.env.example` to `.env`

### Docker Setup (Recommended)

3. Build the docker image
```bash
docker compose build server
```

4. Bring up the container like so
```bash
docker compose up server
```

5. That's it! feel free to visit the project at http://localhost:3000

### Non-Docker Setup

3. Install the gems
```bash
bundle install
```

4. Make a PostgreSQL DB and add an entry to the `.env` file with your DB Connection URL
```bash
DATABASE_URL=postgres://postgres:3x4mpl3@postgres:5432/coding-assessment_development
```

5. Setup the DB
```bash
rails db:prepare
```

6. Run the server with the following command
```bash
rails server -p 3000
```

7. That's it! feel free to visit the project at http://localhost:3000

## Using the API

I've included a postman collection with the available routes under `./Elevate - Coding Assessment.postman_collection.json`

**Heads Up**: The API requires the token that is given after sign up/log in to be present in the headers like so
```json
{
  "Authorization": "Bearer TOKEN_HERE"
}
```

## Running the Tests

### Docker

The setup is basically the same as running the project but with the following changes

1. Build the docker image
```bash
docker compose build test
```

2. Bring up the container like so
```bash
docker compose up test
```

Afterwards, it shouls automatically run rspec for you and show you the results.

### Non-Docker

1. Make a PostgreSQL DB and add an entry to the `.env` file with your DB Connection URL
```bash
DATABASE_URL=postgres://postgres:3x4mpl3@postgres:5432/coding-assessment_test
```

2. Setup the DB
```bash
rails db:prepare RAILS_ENV=test
```

3. Run the tests
```bash
rspec spec/
```

Afterwards, it shouls run rspec and show you the results.