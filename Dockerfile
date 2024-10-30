# Use the official Ruby image for 2.7.2
FROM ruby:2.7.2

# Set environment variables for Bundler
ENV BUNDLER_VERSION=2.2.22
ENV RAILS_ENV=development
ENV RACK_ENV=development

# Install necessary packages for Rails
RUN apt-get update -qq && \
    apt-get install -y nodejs yarn build-essential libpq-dev

# Set up working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock for dependency installation
COPY Gemfile Gemfile.lock ./

# Install Bundler and Rails dependencies
RUN gem install bundler -v "$BUNDLER_VERSION" && \
    bundle install --jobs 4 --retry 3

# Copy the rest of the app files
COPY . .

# Precompile assets
# RUN RAILS_ENV=development bundle exec rails assets:precompile

# Expose port 3000 for the Rails app
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
