FROM ruby:2.1.10-alpine

ENV APP_HOME=/app
WORKDIR $APP_HOME

RUN apk add --update --no-cache nodejs build-base libxml2-dev libxslt-dev ruby-dev \
    && bundle config build.nokogiri --use-system-libraries

# Install dependencies defined in Gemfile.
COPY Gemfile Gemfile.lock $APP_HOME/

# Copy application sources.
COPY . $APP_HOME

ENV BUNDLE_PATH /box

# The main command to run when the container starts.
CMD ["bundle", "exec", "middleman"]
