FROM ruby:3.1.2-alpine3.16@sha256:05b990dbaa3a118f96e9ddbf046f388b3c4953d5ef3d18908af96f42c0e138d9

WORKDIR /app

# Edge repo is necessary for Node 16 and openssl 3
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk update
RUN apk upgrade --available
RUN apk add libc6-compat openssl-dev build-base libpq-dev yarn nodejs=16.19.1-r0 npm
RUN adduser -D ruby
RUN mkdir /node_modules && chown ruby:ruby -R /node_modules /app

USER ruby

COPY --chown=ruby:ruby Gemfile* ./
RUN gem install bundler -v 2.3.20
RUN bundle install --jobs "$(nproc)"

COPY --chown=ruby:ruby package.json *yarn* ./
RUN yarn install --modules-folder /node_modules

ENV RAILS_ENV="${RAILS_ENV:-production}" \
    NODE_ENV="${NODE_ENV:-production}" \
    PATH="${PATH}:/home/ruby/.local/bin:/node_modules/.bin" \
    USER="ruby" \
    REDIS_URL="${REDIS_URL:-redis://notset/}"

COPY --chown=ruby:ruby . .

CMD ["bash"]

ENV RAILS_ENV="${RAILS_ENV:-production}" \
    PATH="${PATH}:/home/ruby/.local/bin" \
    USER="ruby"

WORKDIR /app

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
