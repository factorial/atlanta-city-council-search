FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y postgresql-client curl libpq-dev

WORKDIR /atlcc

COPY Gemfile /atlcc/Gemfile
COPY Gemfile.lock /atlcc/Gemfile.lock

RUN gem install bundler:1.15.4
RUN bundle install

COPY . /atlcc

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
