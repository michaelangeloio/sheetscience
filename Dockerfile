FROM php:7.4-fpm

COPY composer.json /var/www/

WORKDIR /var/www

RUN apt-get update --fix-missing && apt-get install -y \
    git \
    curl \
    nano \
    libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev \
    iputils-ping \
    zip unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd
RUN docker-php-ext-install mbstring exif pcntl pdo pdo_mysql mysqli opcache

RUN apt-get update -y
RUN apt-get install -y libgmp-dev re2c libmhash-dev libmcrypt-dev file
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/
RUN docker-php-ext-configure gmp 
RUN docker-php-ext-install gmp


RUN echo extension=gmp.so > /usr/local/etc/php/conf.d/gmp.ini


COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www

RUN adduser www-data root

EXPOSE 9000

CMD ["php-fpm"]
