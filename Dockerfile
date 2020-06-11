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

COPY --from=builder /app/build /app/build/usr/share/nginx/html