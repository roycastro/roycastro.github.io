FROM node:8-alpine as builder

LABEL maintainer-name="Roy Castro"

LABEL maintainer-email="rcastro9007@gmail.com"

LABEL maintainer-site="https://roycastro.github.io/"

RUN apk update && apk upgrade && \
  apk add --no-cache bash git

COPY package.json package-lock.json ./

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

RUN npm i && mkdir /portfolio && cp -R ./node_modules ./portfolio

WORKDIR /portfolio

COPY . .

## Build the angular app in production mode and store the artifacts in dist folder
RUN npm run build --prod --aot

FROM nginx:1.13.3-alpine

## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=builder /portfolio/dist/portfolio /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
