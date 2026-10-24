FROM nextcloud:stable-apache

ARG DEFAULT_PHONE_REGION=AT
ARG CACHEBUST=1

RUN echo "cachebust=${CACHEBUST}" >/dev/null \
    && apt-get update \
    && apt-get upgrade --assume-yes --no-install-recommends \
    && apt-get install --assume-yes --no-install-recommends \
       tesseract-ocr tesseract-ocr-eng tesseract-ocr-deu \
       ocrmypdf imagemagick ffmpeg \
       smbclient \
       libsmbclient-dev $PHPIZE_DEPS \
    && pecl install smbclient \
    && docker-php-ext-enable smbclient \
    && apt-get purge --assume-yes --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
       libsmbclient-dev $PHPIZE_DEPS \
    && apt-get clean \
    && rm -rf /tmp/pear /var/lib/apt/lists/* /var/cache/apt/*

RUN printf "<?php\n\$CONFIG = [\n    'default_phone_region' => '%s',\n];\n" "${DEFAULT_PHONE_REGION}" \
    > /usr/src/nextcloud/config/default_phone_region.config.php
