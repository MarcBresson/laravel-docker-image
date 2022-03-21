FROM php:8.1.2-fpm-buster

RUN docker-php-ext-install bcmath pdo_mysql

RUN apt-get update
RUN apt-get install -y git zip unzip supervisor

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

EXPOSE 9000

COPY ./laravel-queue.sh /usr/local/bin/laravel-queue
COPY ./laravel-scheduler.sh /usr/local/bin/laravel-scheduler

RUN chmod u+x /usr/local/bin/laravel-queue \
    && chmod u+x /usr/local/bin/laravel-scheduler \
    && chown -R www-data:www-data /var/www/
