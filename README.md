# 🚀 Rapidex - Plataforma de Logística e Rastreamento

> Sistema completo de logística estilo iFood/Loggi com filas, jobs, eventos e tempo real.

![Laravel](https://img.shields.io/badge/Laravel-11.x-red?style=flat-square&logo=laravel)
![PHP](https://img.shields.io/badge/PHP-8.3-blue?style=flat-square&logo=php)
![Docker](https://img.shields.io/badge/Docker-Compose-blue?style=flat-square&logo=docker)
![Redis](https://img.shields.io/badge/Redis-7.x-red?style=flat-square&logo=redis)

## 🎯 **Funcionalidades**

### 📦 **Gestão de Pedidos**
- [x] Cliente cadastra pedido
- [x] Processamento assíncrono via filas
- [x] Cálculo automático de rotas e valores
- [x] Matching inteligente com entregadores

### 🚴 **Sistema de Entregadores**
- [x] Cadastro e verificação de documentos
- [x] Rastreamento em tempo real
- [x] Sistema de avaliações
- [x] Notificações push/SMS/email

### ⚡ **Jobs & Eventos**
- [x] `ProcessOrderJob` - Cálculo de rotas
- [x] `NotifyCourierJob` - Notificações para entregadores
- [x] `GenerateReportJob` - Relatórios pesados
- [x] `RetryFailedNotificationsJob` - Retry automático

### 📊 **Monitoramento**
- [x] Laravel Horizon (filas)
- [x] Laravel Telescope (debugging)
- [x] Rate limiting
- [x] Health checks

## 🏗️ **Arquitetura**

```
┌─────────────────┐    ┌──────────────┐    ┌─────────────────┐
│   Nginx Proxy   │────│  Laravel App │────│  MySQL Database │
└─────────────────┘    └──────────────┘    └─────────────────┘
                              │
                    ┌─────────┼─────────┐
                    │         │         │
            ┌───────▼───┐ ┌───▼────┐ ┌──▼──────┐
            │  Redis    │ │Horizon │ │ Queue   │
            │(Cache+Job)│ │Monitor │ │Workers  │
            └───────────┘ └────────┘ └─────────┘
```

## 🚀 **Quick Start**

### Pré-requisitos
- Docker & Docker Compose
- Git
- [Claude Code](https://docs.anthropic.com/claude/docs/claude-code) (opcional)

### 1. Clone e Configure
```bash
git clone <seu-repositorio>
cd rapidex

# Copiar ambiente
cp src/.env.example src/.env

# Subir containers
docker-compose up -d
```

### 2. Configurar Aplicação
```bash
# Gerar chave da aplicação
docker-compose exec laravel.test php artisan key:generate

# Rodar migrations
docker-compose exec laravel.test php artisan migrate

# Seeders iniciais
docker-compose exec laravel.test php artisan db:seed
```

### 3. Acessar
- **App Principal**: http://localhost
- **Horizon**: http://localhost:8080
- **MailHog**: http://localhost:8025  
- **Meilisearch**: http://localhost:7700

## 🧪 **Desenvolvimento**

### Com Claude Code
```bash
# Instalar Claude Code
curl -fsSL https://claude.ai/install.sh | sh

# Usar no projeto
claude-code --project rapidex
```

### Comandos Úteis
```bash
# Logs em tempo real
docker-compose logs -f laravel.test

# Rodar testes
docker-compose exec laravel.test php artisan test

# Queue debugging
docker-compose exec laravel.test php artisan queue:work --verbose

# Limpar caches
docker-compose exec laravel.test php artisan optimize:clear
```

### Estrutura do Código
```
src/
├── app/
│   ├── Jobs/           # Jobs assíncronos
│   ├── Events/         # Eventos do sistema
│   ├── Listeners/      # Listeners de eventos
│   ├── Services/       # Lógica de negócio
│   └── Http/Controllers/Api/  # Controllers da API
├── database/
│   ├── migrations/     # Schema do banco
│   └── seeders/        # Dados iniciais
└── tests/
    ├── Feature/        # Testes de integração
    └── Unit/          # Testes unitários
```

## 📡 **API Endpoints**

### Autenticação
```http
POST /api/auth/login
POST /api/auth/register
POST /api/auth/logout
```

### Pedidos
```http
GET    /api/orders           # Listar pedidos
POST   /api/orders           # Criar pedido
GET    /api/orders/{id}      # Detalhar pedido
PATCH  /api/orders/{id}      # Atualizar status
```

### Entregadores
```http
GET    /api/couriers         # Listar entregadores
POST   /api/couriers/{id}/accept/{order}  # Aceitar pedido
PATCH  /api/couriers/{id}/location        # Atualizar localização
```

## 🔄 **Workflow de Desenvolvimento**

### Branches
- `main` → Produção
- `develop` → Desenvolvimento
- `feature/[nome]` → Features específicas

### Commits Semânticos
```bash
feat: nova funcionalidade
fix: correção de bug
docs: documentação
test: testes
refactor: refatoração
perf: performance
```

## 🚀 **Deploy**

### Staging
```bash
git push origin develop
# Auto-deploy via GitHub Actions
```

### Produção
```bash
git checkout main
git merge develop
git tag v1.0.0
git push origin main --tags
```

## 🤝 **Contribuição**

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📝 **Documentação**

- [📚 Documentação Técnica](./docs/README.md)
- [🐳 Setup Docker](./docs/docker.md)
- [⚡ Jobs & Eventos](./docs/jobs-events.md)
- [🧪 Testes](./docs/testing.md)

## 📄 **Licença**

Este projeto está sob licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

**Feito com ❤️ usando Laravel, Docker e muito ☕**
