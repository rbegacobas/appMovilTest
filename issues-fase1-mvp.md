# Issues Fase 1 (MVP) - appMovilTest

## 🏗️ Tareas Iniciales de Infraestructura

- [ ] Crear repositorio y estructura de carpetas del proyecto.
- [ ] Inicializar proyecto Flutter (`client_app`).
- [ ] Configurar Firebase en el proyecto (consola y app).
- [ ] Inicializar proyecto de funciones backend (`backend`).

## 👤 Módulo de Autenticación

- [ ] Implementar registro y login de clientes (Firebase Auth).
- [ ] Implementar login de trabajadores (Firebase Auth, validando rol).
- [ ] Validar roles de usuario tras autenticación.

## 💸 Módulo de Servicios y Pedidos

- [ ] Crear modelo de datos para usuarios, pedidos y promociones.
- [ ] Implementar pantalla de selección de servicios (remesas/recargas).
- [ ] Implementar pantalla para crear un pedido (selección de paquete o monto personalizado).
- [ ] Integrar generación de enlace y QR de Mercado Pago.
- [ ] Implementar lógica para guardar pedido en Firestore con estado “creado”.

## 🔔 Notificaciones y Actualización en Tiempo Real

- [ ] Configurar Firebase Cloud Messaging (FCM) en la app.
- [ ] Implementar recepción de notificaciones push para clientes y trabajadores.
- [ ] Implementar actualización en tiempo real del estado de los pedidos (Firestore listeners).

## 👷‍♂️ Módulo de Trabajadores

- [ ] Implementar pantalla de pedidos pendientes para trabajadores.
- [ ] Implementar lógica de “primer trabajador que acepta” usando transacciones atómicas en Firestore.
- [ ] Implementar pantalla para actualizar estado del pedido (“procesando”, “completado”).

## 🧾 Historial y Gestión de Pedidos

- [ ] Implementar pantalla de historial de pedidos para clientes.
- [ ] Implementar pantalla de pedidos asignados para trabajadores.

## 🔗 Integración con Mercado Pago y Webhooks

- [ ] Crear función backend para recibir Webhooks de Mercado Pago.
- [ ] Implementar lógica para actualizar estado del pedido a “pagado” tras recibir Webhook.
- [ ] Proteger endpoint de Webhook (validación de origen).

## 🛡️ Seguridad

- [ ] Configurar reglas de seguridad de Firestore.
- [ ] Validar acceso a datos según rol (cliente, trabajador).

## 🧪 QA y Pruebas

- [ ] Probar flujo completo de registro, login y creación de pedido.
- [ ] Probar asignación de pedidos y actualización de estado.
- [ ] Probar recepción de notificaciones push.

---

Puedes copiar y pegar cada tarea como issue en GitHub, o usar este archivo como checklist general.