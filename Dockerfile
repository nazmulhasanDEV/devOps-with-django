FROM nginx:stable-alpine


# Instructions
RUN apk update && apk add bash

COPY app ./app