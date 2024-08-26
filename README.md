## Install

### Clone the repository

```shell
git clone git@github.com:diego-oliveira/signal-wire-api.git
cd signal-wire-api
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.2.2`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.2.2
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```
We are using sidekiq to run the jobs. Make sure redis are up and running in your machine.

### Set environment variables

Copy the [.env.example](https://github.com/diego-oliveira/signal-wire-api/blob/master/.env.example) file to a `.env` file on root folder. Adapt the variables to your needs.

### Initialize the database

```shell
rails db:create db:migrate
```

## Serve

```shell
rails s
```

## Create tickets example

```shell
 curl --location --request POST 'http://localhost:3000/api/v1/tickets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user_id" : 123,
    "title" : "title",
    "tags" : ["one", "two"]
} '
```
