FROM python:3.14.0a3-alpine

ARG USERNAME
RUN adduser -D ${USERNAME}
ENV DB_URL=http://db-url.pg
# Instructions
RUN apk update && apk add bash

# EXPOSE 4000

# COPY app ./app

WORKDIR /home/${USERNAME}
ADD . .

# RUN ls /home/${USERNAME}
# ENTRYPOINT [ "python3" ]
CMD python3 ./main.py