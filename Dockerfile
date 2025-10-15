# Use a imagem oficial do PHP com Apache (ou FPM se preferir)
FROM php:8.2-apache

# Definir variáveis de ambiente para não interações durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências e extensões necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libpq-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql pdo_pgsql zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ativar módulos do Apache (se estiver usando Apache)
RUN a2enmod rewrite

# Definir diretório de trabalho
WORKDIR /var/www/html

# Copiar código do projeto (opcional)
# COPY . /var/www/html

# Expor porta 80
EXPOSE 80

# Comando padrão ao iniciar o container
CMD ["apache2-foreground"]
