FROM alpine:3.9
LABEL Author="Alexander Shumenko <alexander.shumenko@gmail.com>" Description="A Simple apache/php image using alpine Linux for Drupal sites"
RUN apk update && apk upgrade && apk add --no-cache apache2 apache2-utils bash php7 php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-xdebug php7-common php7-ldap php7-json php7-xml php7-dom && \
    apk add php7-memcached php7-phar php7-iconv wget msmtp memcached mysql-client mc htop git && \
    ln -sf /usr/bin/msmtp /usr/sbin/sendmail && \
    wget https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
	chmod +x mhsendmail_linux_amd64 && mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail && \
	sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf && \
	sed -i '/LoadModule ssl_module/s/^#//g' /etc/apache2/httpd.conf && \
	sed -i '/LoadModule headers_module/s/^#//g' /etc/apache2/httpd.conf && \
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
    ~/.bash_it/install.sh && \
	sed -i -e 's/bobby/powerline-plain/g' /root/.bashrc && source /root/.bashrc

CMD /bin/bash