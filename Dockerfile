FROM nginx:mainline-alpine
USER root
RUN apk add --no-cache netcat-openbsd bind-tools inetutils-telnet less curl aws-cli
RUN mkdir /.aws && chown 10000:20000 /.aws
# RUN apt-get update && apt-get -y install gpg
# RUN curl -kfsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
# RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] http://packages.redis.io/deb buster main" > /etc/apt/sources.list.d/redis.list
# RUN apt-get update && apt-get install -y redis-tools postgresql-client
RUN rm -rf /docker-entrypoint.d
COPY nginx.conf /etc/nginx/nginx.conf
USER 10000:20000
COPY index.html /usr/share/nginx/html
COPY HCS.png /usr/share/nginx/html
