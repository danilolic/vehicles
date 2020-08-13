# README

Simple API written in Rails 6 to handle vehicles, models and brands.
Ruby Version 2.7.0

## Getting Started

### Setup the project
```bash
git clone https://github.com/danilolic/vehicles.git
cd vehicle
bundle install
rails db:create db:migrate db:seed
```
With db:seed you can get some samples to query.

### Initialize

```bash
rails s
```

You can see the API docs here:

https://documenter.getpostman.com/view/6655494/T1LLDTCb

### Authentication:
The api uses JWT with refresh tokens as strategy to authentication if you are not familiar see that:

https://auth0.com/blog/refresh-tokens-what-are-they-and-when-to-use-them/

### Nested Routes (I know this is outside the initial specification)

The api uses nested routes to improve readability.

### Coverage

You can see the test coverage opening on the browser the file coverage/index.html

### Code Quality

You can see the code quality running on the root folder:

```bash
rubycritic app/
```

Security Issues:

You can see for security issue running on the root folder:

```bash
brakeman
```
