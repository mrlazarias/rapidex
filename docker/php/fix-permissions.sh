#!/bin/bash

echo "🔧 Corrigindo permissões do Laravel..."

# Criar diretórios necessários
mkdir -p storage/framework/{sessions,views,cache,testing}
mkdir -p storage/framework/cache/data
mkdir -p storage/{app,logs}
mkdir -p bootstrap/cache

# Permissões completas para storage e bootstrap/cache
chmod -R 777 storage/
chmod -R 777 bootstrap/cache/

# Propriedade para www-data (usuário do PHP-FPM)
chown -R www-data:www-data storage/
chown -R www-data:www-data bootstrap/cache/

echo "✅ Permissões corrigidas!"
