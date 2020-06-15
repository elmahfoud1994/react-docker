# SELECT base image
FROM node:alpine as builder

#Install dependencies
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

# Startup command
RUN npm run build

FROM nginx

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'
COPY --from=builder /app/build/ /usr/share/nginx/html