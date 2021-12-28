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
# # RUN chgrp -R root /var/cache/nginx /var/run /var/log/nginx && \
# #     chmod -R 770 /var/cache/nginx /var/run /var/log/nginx

##new version
FROM nginx:1.13.3-alpine
RUN rm -rf /etc/nginx/nginx.conf.default && rm -rf /etc/nginx/conf.d/default.conf
COPY /nginx.conf /etc/nginx/nginx.conf
COPY /nginx.conf /etc/nginx/conf.d/nginx.conf

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*
# Copy code from dist folder to nginx folder
COPY  /dist/sunangapp/ /usr/share/nginx/html
RUN chgrp -R 0 /var/cache/ /var/log/ /var/run/ && \
    chmod -R g=u /var/cache/ /var/log/ /var/run/
EXPOSE 9090
#Entry point of application
ENTRYPOINT ["nginx", "-g", "daemon off;"]