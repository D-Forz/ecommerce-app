# Ecommerce App

## Tech Stack
**Client:** Tailwindcss

**Server:** Ruby on Rails 7

#### Catecteristics
- Authentication
- Authorization
- Languages (EN ES)
- Pagination
- Hotwire
- Mailers
- Jobs
- Specs
- Components
- API Integration

## Run Locally

Clone the project

```bash
  git clone https://github.com/D-Forz/ecommerce-app.git
```

Go to the project directory

```bash
  cd ecommerce-app
```

Install dependencies

```bash
  bundle install
```
Run the migrations and seeds ( be sure you have the database created)

```bash
  rails db:migrate
  rails db:seeds
```

Start the server
```bash
  dev
```

## Running Tests

To run all the tests in local, run the following command
```bash
  rails spec 
```

to run individual specs
```bash
  rails spec:components
  rails spec:models
  rails spec:requests
  rails spec:jobs
  rails spec:mailers
  rails spec:services
```


## Production environment
```bash
bundle lock --add-platform x86_64-linux
```

## Screenshots
![Products](https://user-images.githubusercontent.com/90451710/220334952-935b8dff-4eb4-4110-8765-8011e5242150.jpeg)


## Appendix
Rails app generated with [minimal](https://github.com/D-Forz/ruby-projects/tree/master/templates)
