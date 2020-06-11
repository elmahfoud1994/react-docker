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
EXPOSE 80

COPY --from=builder /app/build/ /usr/share/nginx/html