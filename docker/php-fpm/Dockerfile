FROM php:5.6.31-fpm

ARG COMPOSER_VERSION=1.3.0
ENV GOSU_VERSION 1.10

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    locales \
    git \
    unzip \
    zlib1g-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libxml2-dev \
    graphicsmagick \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove wget

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install zip \
    gd \
    opcache \
    xmlrpc \
    soap \
    mysqli \
    intl

ADD php.ini /usr/local/etc/php/conf.d/99-custom.ini
ADD www.conf /usr/local/etc/php-fpm.d/www.conf

RUN curl -o /usr/local/bin/composer https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar && \
    chmod +x /usr/local/bin/composer

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\nblackfire.log_file = /tmp/blackfire.log\n" > $PHP_INI_DIR/conf.d/blackfire.ini

# Set locale
RUN sed -ie 's/^# \(de_DE.UTF-8\)/\1/' /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales
ENV LANGUAGE=de_DE.utf8
ENV LANG de_DE.utf8
ENV LC_ALL de_DE.utf8
RUN update-locale

RUN usermod -m -d /home/www-data www-data \
    && chown www-data:www-data -R /home/www-data

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod a+x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["php-fpm"]
