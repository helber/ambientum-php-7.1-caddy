#####
# Ambientum 1.0
# PHP 7.0 bundled with the Awesome Caddy webserver
######
FROM ambientum/php:7.1

# Repository/Image Maintainer
MAINTAINER Weslley Camilo

# Reset user to root to allow software install
USER root

# Copy Caddyfile and entry script
COPY Caddyfile /home/ambientum/Caddyfile
COPY start.sh  /home/ambientum/start.sh

# Installs Caddy
RUN curl https://getcaddy.com | bash && \
    chmod +x /home/ambientum/start.sh && \
    chown -R ambientum:ambientum /home/ambientum

# Installs Confd
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 -O /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd && \
    mkdir -p /etc/confd/conf.d /etc/confd/templates

LABEL \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.s2i.scripts-url=image:///usr/libexec/s2i

COPY ./s2i/bin/ /usr/libexec/s2i

# Define the running user
# USER 1001

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and caddy on foreground
CMD ["/home/ambientum/start.sh"]
