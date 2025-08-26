FROM php:8.3-fpm

ARG user=rapidex
ARG uid=1000

# Instalar dependências
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev libzip-dev \
    zip unzip supervisor cron netcat-openbsd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Extensões PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip sockets
RUN pecl install redis && docker-php-ext-enable redis

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Criar usuário com UID correto
RUN groupadd --gid $uid $user \
    && useradd --uid $uid --gid $user --shell /bin/bash --create-home $user \
    && usermod -a -G www-data $user

WORKDIR /var/www/html

# Scripts
COPY start-container.sh /usr/local/bin/start-container
COPY fix-permissions.sh /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/start-container /usr/local/bin/fix-permissions

# Criar diretórios e permissões
RUN mkdir -p storage/framework/{sessions,views,cache,testing} \
    && mkdir -p storage/{app,logs} \
    && mkdir -p bootstrap/cache \
    && chown -R $user:$user storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

EXPOSE 9000
USER $user
CMD ["start-container"]
