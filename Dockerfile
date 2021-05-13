FROM node:lts-alpine as base

#RUN apk add --no-cache --virtual .build-deps alpine-sdk python
#USER node
#RUN mkdir -p /home/node/app
#WORKDIR /home/node/app
#COPY . .
#RUN npm install --production #--silent
#RUN apk del .build-deps

WORKDIR /app
RUN apk add --no-cache --virtual .build-deps build-base alpine-sdk python
COPY package.json package.json
RUN npm install # --production --silent
RUN apk del .build-deps

#COPY . .
COPY jsconfig.json .babelrc .eslintrc.js .flowconfig ./
RUN mkdir scripts src extension public flow-typed
COPY src src/
COPY flow-typed flow-typed/
COPY extension extension/
COPY scripts scripts/
COPY public public/
COPY .env.production ./
ENV REACT_APP_VERSION=$npm_package_version
RUN npm run build

FROM nginx:stable-alpine as production-stage
COPY --from=base /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
COPY entrypoint.sh .

EXPOSE 80
ENTRYPOINT ["./entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
