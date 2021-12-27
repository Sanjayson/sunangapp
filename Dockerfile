#Stage 0
FROM node:14-alpine as build-stage
WORKDIR /app
COPY package*.json /app/
#RUN npm install
COPY ./ /app/
#ARG configuration=production
#RUN npm run build -- --output-path=./dist/sunangapp --configuration $configuration

#Stage 1
FROM nginx:1.17.1-alpine
COPY --from=build-stage /app/dist/sunangapp/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf