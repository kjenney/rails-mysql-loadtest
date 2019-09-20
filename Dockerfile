FROM ruby:2.5.6

## Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs mariadb-client netcat net-tools
RUN gem install bundler

RUN gem install rails -v 5.2.0
RUN rails new myapp -d mysql

WORKDIR /myapp

# Add faker to insert data
RUN bundle add faker --group "development, test"

# Add unicorn to fork off Rails processes
RUN bundle add unicorn --group "development, test"

# Add rails files
COPY rails/ ./

# Add a script to be executed every time the container starts.
RUN mv entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
