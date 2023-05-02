# Use base image with Ruby installed
FROM ruby:2.7-buster

# install required system packages
RUN apt-get update -qq && \
    apt-get install -y build-essential

# create application directory and install dependencies
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY raddit-app/Gemfile* $APP_HOME/
RUN bundle install

# Copy the application code to the container
ADD raddit-app/ $APP_HOME

EXPOSE 9292
# Run "puma" command on container's start
CMD ["puma"]
