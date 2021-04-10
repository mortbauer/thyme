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
RUN npm install --production --silent
RUN apk del .build-deps

ENV REACT_APP_API_ROOT "__API_URL__"
ENV REACT_APP_TAB_URL "__PUBLIC_URL__"
COPY . .
RUN npm run build

FROM nginx:stable-alpine as production-stage
COPY --from=base /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
COPY entrypoint.sh .

EXPOSE 80
ENTRYPOINT ["./entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
