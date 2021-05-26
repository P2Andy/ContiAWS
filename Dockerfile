# Version: 0.0.1
FROM nginx:latest
MAINTAINER Andrei Pokhilenko <Pokhilenko.An@khortitsa.com.com>
RUN apt-get update && apt-get install -y nginx

COPY ./index.html /usr/share/nginx/html/index.html

EXPOSE 80

#ENTRYPOINT ["/etc/init.d/nginx start"]
CMD ["nginx", "-g", "daemon off;"]
