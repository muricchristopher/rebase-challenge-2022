FROM ruby
WORKDIR /app
COPY . .
RUN bundle install
