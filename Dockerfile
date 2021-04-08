FROM node:lts-alpine as base

#RUN apk add --no-cache --virtual .build-deps alpine-sdk python
#USER node
#RUN mkdir -p /home/node/app
#WORKDIR /home/node/app
#COPY . .
#RUN npm install --production #--silent
#RUN apk del .build-deps

RUN apk add --no-cache --virtual .build-deps build-base alpine-sdk python
COPY . .
RUN npm install --production --silent
RUN apk del .build-deps

CMD ["npm","start"]
