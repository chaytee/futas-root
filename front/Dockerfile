FROM node:12.18.3-alpine

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY package.json $APP_HOME
COPY package.lock.json $APP_HOME

RUN apk update && npm install -g @vue/cli