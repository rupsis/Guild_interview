FROM ruby:2.3.8

WORKDIR /server
COPY . /server

RUN gem install sinatra

EXPOSE 3000

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "3000"]