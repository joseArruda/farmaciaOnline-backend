# Usa a imagem base do PHP 8.2 com Apache
FROM php:8.2-apache

# Define o diretório de trabalho
WORKDIR /var/www/html

# Instala dependências do sistema e extensões PHP necessárias para Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql pdo_pgsql zip

# Copia os arquivos do projeto Laravel para dentro do container
COPY . .

# Instala o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Gera a APP_KEY automaticamente (caso não exista)
RUN php artisan key:generate || true

# Ajusta permissões para o Laravel poder escrever no storage e cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expõe a porta 80
EXPOSE 80

# Inicia o servidor Apache
CMD ["apache2-foreground"]
