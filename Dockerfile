FROM joomla:3.8.2-apache-php7
LABEL authors="jin"

# Fix dépôts Debian Stretch (EOL) + installation des dépendances nécessaires à Composer
RUN echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/10no--check-valid-until && \
    sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    sed -i '/jessie-updates/d' /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get -o Acquire::Check-Valid-Until=false install -y --no-install-recommends --allow-unauthenticated curl unzip git && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer --version && \
    rm -rf /var/lib/apt/lists/*

# Installer Composer globalement
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Vérification Composer
RUN composer --version




