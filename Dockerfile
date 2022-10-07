FROM ruby:2.3.0
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash

RUN apt-get update \
 && apt-get install --no-install-recommends -y --force-yes \
  build-essential libpq-dev ca-certificates bzip2 libfontconfig \
  ghostscript nodejs imagemagick

RUN gem install bundler -v 1.17.3
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
