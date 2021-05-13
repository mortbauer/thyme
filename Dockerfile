FROM node:lts-alpine as base

WORKDIR /app
RUN apk add --no-cache --virtual .build-deps build-base alpine-sdk python
COPY package.json package.json
RUN npm install
RUN apk del .build-deps


COPY jsconfig.json .babelrc .eslintrc.js .flowconfig ./
RUN mkdir scripts src extension public flow-typed
COPY src src/
COPY flow-typed flow-typed/
COPY extension extension/
COPY scripts scripts/
COPY public public/

FROM base as build
COPY .env.production ./
RUN npm run build

FROM nginx:stable-alpine as production
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
COPY entrypoint.sh .

EXPOSE 80
ENTRYPOINT ["./entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
