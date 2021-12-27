# #Stage 0
# FROM node:14-alpine as build-stage
# WORKDIR /app
# #COPY package*.json /app/
# #RUN npm install
# COPY ./ /app/
# #ARG configuration=production
# #RUN npm run build -- --output-path=./dist/sunangapp --configuration $configuration

# #Stage 1
# #FROM nginx:1.15
# FROM nginxinc/nginx-unprivileged 
# COPY --from=build-stage /app/dist/sunangapp/ /usr/share/nginx/html
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# RUN chgrp -R root /var/cache/nginx /var/run /var/log/nginx && \
#     chmod -R 770 /var/cache/nginx /var/run /var/log/nginx

FROM nginx:1.13.3-alpine

## Copy our nginx config
COPY nginx.conf /etc/nginx/conf.d/

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## copy over the artifacts in dist folder to default nginx public folder
COPY dist/sunangapp/ /usr/share/nginx/html

RUN chown -R $UID:$GID /var/cache/nginx/client_temp

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]