#!/usr/bin/env bash

echo "🚀 Iniciando container Rapidex..."

# Aguardar MySQL estar pronto
echo "⏳ Aguardando MySQL..."
while ! nc -z mysql 3306; do
    sleep 1
done
echo "✅ MySQL está pronto!"

# Aguardar Redis estar pronto
echo "⏳ Aguardando Redis..."
while ! nc -z redis 6379; do
    sleep 1
done
echo "✅ Redis está pronto!"

# Executar comando baseado na role do container
if [ "$CONTAINER_ROLE" = "horizon" ]; then
    echo "📊 Iniciando Laravel Horizon..."
    exec php artisan horizon
elif [ "$CONTAINER_ROLE" = "queue" ]; then
    echo "⚡ Iniciando Queue Worker..."
    exec php artisan queue:work redis --sleep=3 --tries=3 --max-time=3600 --verbose
elif [ "$CONTAINER_ROLE" = "scheduler" ]; then
    echo "⏰ Iniciando Scheduler..."
    exec php artisan schedule:work
else
    echo "🌐 Iniciando PHP-FPM..."
    exec php-fpm
fi
