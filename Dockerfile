FROM ruby:3.0.0-alpine
RUN apk --no-cache update && apk upgrade && \
    apk add --no-cache curl && \
    apk add --no-cache alpine-sdk && \
    apk add --no-cache linux-headers && \
    apk add --no-cache ca-certificates && update-ca-certificates 2>/dev/null && \
    apk add --no-cache bash && \
    apk add --no-cache dumb-init && \
    apk add --no-cache tzdata && \
    gem update --system && gem install bundler && \
    apk add --no-cache postgresql-dev && \
    apk add --update nodejs npm && \
    apk add ruby ruby-nokogiri && \
    apk add --no-cache gcompat &&  \
    apk add --no-cache nodejs && \
    apk add --no-cache yarn && \
    apk add --no-cache python2 g++ make && \
    yarn install --check-files

WORKDIR /myapp
COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]