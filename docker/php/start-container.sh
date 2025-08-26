#!/usr/bin/env bash

echo "🚀 Iniciando container Rapidex..."

# Corrigir permissões
/usr/local/bin/fix-permissions

# Aguardar serviços
echo "⏳ Aguardando MySQL..."
while ! nc -z mysql 3306; do sleep 1; done
echo "✅ MySQL pronto!"

echo "⏳ Aguardando Redis..."
while ! nc -z redis 6379; do sleep 1; done
echo "✅ Redis pronto!"

# Configurar Laravel se necessário
if [ ! -f .env ]; then
    echo "📝 Copiando .env.example..."
    cp .env.example .env 2>/dev/null || echo "⚠️ .env.example não encontrado"
fi

if ! grep -q "APP_KEY=base64:" .env 2>/dev/null; then
    echo "🔑 Gerando chave da aplicação..."
    php artisan key:generate 2>/dev/null || echo "⚠️ Erro ao gerar chave"
fi

# Executar baseado na role
case "$CONTAINER_ROLE" in
    "horizon")
        echo "📊 Iniciando Horizon..."
        exec php artisan horizon
        ;;
    "queue")
        echo "⚡ Iniciando Queue Worker..."
        exec php artisan queue:work redis --sleep=3 --tries=3 --max-time=3600
        ;;
    "scheduler")
        echo "⏰ Iniciando Scheduler..."
        exec php artisan schedule:work
        ;;
    *)
        echo "🌐 Iniciando PHP-FPM..."
        exec php-fpm
        ;;
esac
