# 🐳 Rapidex - Documentação Docker

## Serviços Configurados

### rapidex.test
- **Imagem**: PHP 8.3-FPM customizada
- **Porta**: 9000 (interna)
- **Função**: Aplicação Laravel principal

### nginx
- **Imagem**: nginx:alpine
- **Portas**: 80, 443
- **Função**: Proxy reverso + servidor web

### mysql
- **Imagem**: mysql:8.0
- **Porta**: 3306
- **Database**: rapidex_db
- **Usuário**: rapidex_user

### redis
- **Imagem**: redis:7-alpine
- **Porta**: 6379
- **Função**: Cache + Filas + Sessões

### meilisearch
- **Imagem**: getmeili/meilisearch:v1.5
- **Porta**: 7700
- **Função**: Busca rápida

### horizon
- **Função**: Monitor de filas Laravel
- **Interface**: http://localhost/horizon

### mailhog
- **Portas**: 1025 (SMTP), 8025 (Web)
- **Interface**: http://localhost:8025

## Comandos Úteis

```bash
# Subir todos os serviços
docker-compose up -d

# Ver logs em tempo real
docker-compose logs -f rapidex.test

# Executar artisan
docker-compose exec rapidex.test php artisan migrate

# Acessar container
docker-compose exec rapidex.test bash

# Ver status
docker-compose ps

# Parar tudo
docker-compose down

# Rebuild
docker-compose up -d --build
```

## Volumes Persistentes

- `rapidex_mysql_data`: Dados do MySQL
- `rapidex_redis_data`: Dados do Redis  
- `rapidex_search_data`: Índices Meilisearch

## Environment Variables

Configure no arquivo `src/.env`:

```env
APP_NAME=Rapidex
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=rapidex_db
DB_USERNAME=rapidex_user
DB_PASSWORD=rapidex123

REDIS_HOST=redis
REDIS_PORT=6379

QUEUE_CONNECTION=redis
BROADCAST_DRIVER=pusher

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
```
