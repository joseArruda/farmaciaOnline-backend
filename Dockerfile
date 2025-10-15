# Usa uma imagem base PHP 8.2 com FPM
FROM php:8.2-fpm

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql pdo_pgsql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala o Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho no container
WORKDIR /var/www/html

# Copia todos os arquivos do Laravel
COPY . .

# Instala dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Dá permissão para storage e bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache || true

# Gera a chave da aplicação Laravel (ignora erro se já existir)
RUN php artisan key:generate --force || true

# Expõe a porta 8000 e inicia o servidor
EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
