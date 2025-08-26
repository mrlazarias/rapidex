# 🐳 Documentação Docker

## Serviços Configurados

### laravel.test
- **Imagem**: PHP 8.3-FPM customizada
- **Porta**: 9000 (interna)
- **Volumes**: código fonte, configurações PHP
- **Dependências**: MySQL, Redis

### nginx
- **Imagem**: nginx:alpine
- **Portas**: 80, 443
- **Recursos**: Rate limiting, Gzip, Cache headers
- **SSL**: Pronto para certificados (volume)

### mysql
- **Imagem**: mysql:8.0
- **Porta**: 3306
- **Configurações**: UTF8MB4, performance otimizada
- **Volume**: Persistente para dados

### redis
- **Imagem**: redis:7-alpine
- **Porta**: 6379
- **Configurações**: Persistência, maxmemory
- **Uso**: Cache + Filas + Sessões

### meilisearch
- **Imagem**: getmeili/meilisearch:v1.5
- **Porta**: 7700
- **Master Key**: logistics_search_master_key_2024
- **Volume**: Persistente para índices

### horizon
- **Baseado em**: Laravel container
- **Função**: Monitor de filas
- **Interface**: http://localhost:8080
- **Auto-restart**: Sim

### queue-worker
- **Baseado em**: Laravel container  
- **Função**: Processar jobs
- **Configuração**: 3 tentativas, timeout 3600s
- **Auto-restart**: Sim

### mailhog
- **Imagem**: mailhog/mailhog
- **Portas**: 1025 (SMTP), 8025 (Web)
- **Função**: Capturar emails em desenvolvimento

## Comandos Úteis

```bash
# Subir todos os serviços
docker-compose up -d

# Ver logs em tempo real
docker-compose logs -f laravel.test

# Executar artisan
docker-compose exec laravel.test php artisan migrate

# Acessar container
docker-compose exec laravel.test bash

# Ver status dos serviços
docker-compose ps

# Parar tudo
docker-compose down

# Rebuild containers
docker-compose up -d --build

# Ver uso de recursos
docker stats
```

## Volumes Persistentes

- `mysql_data`: Dados do MySQL
- `redis_data`: Dados do Redis  
- `meilisearch_data`: Índices de busca

## Networks

- `logistics_network`: Rede interna para comunicação entre containers
