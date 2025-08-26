# 📡 Rapidex - API Documentation

## Authentication

Rapidex usa **Laravel Sanctum** para autenticação API.

### Login
```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@rapidex.com",
  "password": "password"
}
```

### Register
```http
POST /api/auth/register
Content-Type: application/json

{
  "name": "João Silva",
  "email": "joao@rapidex.com",
  "password": "password",
  "password_confirmation": "password",
  "role": "customer"
}
```

## Orders API

### List Orders
```http
GET /api/orders
Authorization: Bearer {token}
```

### Create Order
```http
POST /api/orders
Authorization: Bearer {token}
Content-Type: application/json

{
  "pickup_address": {
    "street": "Rua A, 123",
    "city": "São Paulo",
    "zipcode": "01234-567"
  },
  "pickup_latitude": -23.5505,
  "pickup_longitude": -46.6333,
  "delivery_address": {
    "street": "Rua B, 456", 
    "city": "São Paulo",
    "zipcode": "09876-543"
  },
  "delivery_latitude": -23.5489,
  "delivery_longitude": -46.6388,
  "description": "Entrega de documento",
  "weight": 0.5,
  "category": "document"
}
```

### Get Order
```http
GET /api/orders/{id}
Authorization: Bearer {token}
```

### Update Order Status
```http
PATCH /api/orders/{id}/status
Authorization: Bearer {token}
Content-Type: application/json

{
  "status": "picked_up"
}
```

## Couriers API

### List Available Couriers
```http
GET /api/couriers/available
Authorization: Bearer {token}

Query Parameters:
- latitude: float
- longitude: float  
- radius: float (km, default: 10)
```

### Accept Order (Courier)
```http
POST /api/couriers/{courier_id}/accept/{order_id}
Authorization: Bearer {token}
```

### Update Location (Courier)
```http
PATCH /api/couriers/{id}/location
Authorization: Bearer {token}
Content-Type: application/json

{
  "latitude": -23.5505,
  "longitude": -46.6333
}
```

## WebSocket Events

### Order Updates
```javascript
// Channel: order.{orderId}
Echo.channel('order.123')
    .listen('OrderStatusChanged', (e) => {
        console.log('Status:', e.order.status);
    });
```

### Courier Location
```javascript  
// Channel: courier.{courierId}
Echo.channel('courier.456')
    .listen('CourierLocationUpdated', (e) => {
        console.log('Location:', e.latitude, e.longitude);
    });
```

## Error Responses

```json
{
  "message": "Validation failed",
  "errors": {
    "email": ["The email field is required."]
  }
}
```

### Status Codes
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Validation Error
- `500` - Server Error
