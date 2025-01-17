# Base image with Ruby
FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    git

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Bundler and dependencies
RUN gem install bundler && bundle install

# Copy the rest of the application
COPY . .

# Precompile assets for production (optional for production environments)
RUN bundle exec rake assets:precompile

# Expose port 3000
EXPOSE 3000

# Set the command to start the Rails server
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
