# build
FROM node:16.19.1-bullseye-slim AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# setup nginx
FROM nginx:1.17.1-alpine
COPY .nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/angular-catalog /usr/share/nginx/html
