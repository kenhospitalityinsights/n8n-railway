FROM node:20-alpine

ARG N8N_VERSION=1.107.4

# runtime deps
RUN apk add --no-cache graphicsmagick tzdata libc6-compat

USER root

# build deps only for npm install, then remove
RUN apk add --no-cache --virtual build-dependencies python3 build-base && \
    npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
    apk del build-dependencies

WORKDIR /data
EXPOSE $PORT
ENV N8N_USER_ID=root

# make n8n listen on Railway's $PORT
CMD export N8N_PORT=$PORT && n8n start
