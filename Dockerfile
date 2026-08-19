FROM nextcloud:stable-apache

ARG DEFAULT_PHONE_REGION=AT

RUN apt-get update \
    && apt-get install --assume-yes --no-install-recommends \
       tesseract-ocr tesseract-ocr-eng tesseract-ocr-deu \
       ocrmypdf imagemagick ffmpeg \
       smbclient libsmbclient-dev cifs-utils \
    && pecl install smbclient \
    && docker-php-ext-enable smbclient \
    && apt-get purge --assume-yes libsmbclient-dev \
    && apt-get autoremove --assume-yes \
    && rm -rf /var/lib/apt/lists/*

RUN printf "<?php\n\$CONFIG = [\n    'default_phone_region' => '%s',\n];\n" "${DEFAULT_PHONE_REGION}" \
    > /usr/src/nextcloud/config/default_phone_region.config.php
