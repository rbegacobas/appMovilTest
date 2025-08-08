# masterplan.md

## 📄 Resumen y Objetivos del Proyecto

El objetivo principal es desarrollar una plataforma de servicios digitales que facilite las **remesas** y **recargas** a través de una experiencia de usuario fluida. La aplicación permitirá a los clientes iniciar transacciones, recibir actualizaciones en tiempo real y, a su vez, contará con un sistema eficiente para que los trabajadores acepten y procesen estos pedidos. El negocio será gestionado por un administrador a través de un panel de control dedicado.

## 🎯 Público Objetivo

* **Clientes:** Personas que desean enviar dinero o recargar saldo a través de un canal digital seguro y rápido. Utilizarán la aplicación móvil y, potencialmente, la versión web.
* **Trabajadores:** Personal de la empresa encargado de procesar manualmente las remesas y recargas. Su herramienta principal será la aplicación móvil.
* **Administrador:** El dueño del negocio, responsable de la gestión, supervisión y administración de todas las operaciones, usuarios y promociones a través de un panel web.

## ⚙️ Características y Funcionalidades Principales

### Para Clientes (App Móvil)
- **Autenticación:** Registro y login de usuarios con email y contraseña.
- **Servicios:** Visualización de servicios de remesas y recargas, incluyendo "paquetes" predefinidos y la opción de ingresar un monto personalizado.
- **Transacciones:** Inicio de una transacción que generará un enlace y código QR de Mercado Pago para el pago.
- **Historial:** Vista del historial de sus pedidos con el estado actual de cada uno.
- **Notificaciones:** Recepción de notificaciones push en tiempo real sobre el cambio de estado de sus remesas y recargas.

### Para Trabajadores (App Móvil)
- **Autenticación:** Login exclusivo para trabajadores.
- **Notificaciones:** Notificaciones push en tiempo real para nuevos pedidos sin asignar.
- **Gestión de Pedidos:** Vista de pedidos pendientes y un mecanismo para que el primer trabajador que presione "aceptar" se asigne la tarea, bloqueando el pedido para los demás.
- **Actualización de Estado:** Capacidad para actualizar el estado del pedido (por ejemplo, "procesando", "completado").

### Para el Administrador (Panel Web)
- **Dashboard:** Un panel de control centralizado para visualizar métricas clave (pedidos en curso, completados, total de transacciones, etc.).
- **Gestión de Contenido:** Herramientas para crear, editar y eliminar promociones y ofertas.
- **Gestión de Usuarios:** Creación de nuevos usuarios (trabajadores), gestión de sus perfiles y roles.
- **Supervisión de Pedidos:** Vista detallada de todos los pedidos, su estado, quién lo ha pagado y a qué trabajador está asignado.

## 🚀 Recomendaciones de Stack Tecnológico (Alto Nivel)

* **Frontend (App Clientes/Trabajadores):** **Flutter**. Es la opción ideal para construir la aplicación para Android, iOS y la web desde una sola base de código, lo que reduce costos y tiempo de desarrollo.
* **Backend:** **Firebase**. Recomiendo esta opción por su perfecta integración con Flutter y porque ofrece todas las herramientas que necesitas en una sola plataforma:
    * **Autenticación:** **Firebase Authentication** para el registro y login de usuarios.
    * **Base de Datos:** **Cloud Firestore** para almacenar toda la información (usuarios, pedidos, promociones). Su naturaleza en tiempo real es perfecta para las notificaciones y actualizaciones de estado.
    * **Notificaciones Push:** **Firebase Cloud Messaging (FCM)** para enviar notificaciones a clientes y trabajadores de manera eficiente y escalable.
    * **Almacenamiento de Archivos:** **Firebase Storage** si se necesitara guardar imágenes u otros archivos en el futuro.
* **Pasarela de Pago:** **API de Mercado Pago** para la generación de enlaces de pago y, lo más importante, el uso de **Webhooks** para que nuestro backend se entere de los pagos completados y pueda actualizar el estado de los pedidos.

## 📦 Modelo de Datos Conceptual

* **`Usuarios`:** ID, nombre, email, rol (`cliente`, `trabajador`, `admin`), y otros datos de perfil.
* **`Promociones/Servicios`:** ID, título, descripción, precio, tipo (`remesa`, `recarga`), fecha de expiración.
* **`Pedidos`:** ID, `clienteID`, `trabajadorID` (si está asignado), `monto`, `estado` (`creado`, `pagado`, `en proceso`, `completado`), `metodoDePago`, `fecha`.

## 🎨 Principios de Diseño de Interfaz de Usuario

* **Clientes:** El diseño debe ser limpio, intuitivo y simple, con un proceso de pago claro y una forma sencilla de ver el estado de sus transacciones.
* **Trabajadores:** La interfaz debe ser funcional y directa, mostrando de forma prominente los pedidos pendientes y la información clave de cada uno para una rápida toma de decisiones.
* **Administrador:** El panel web debe ser visualmente claro y fácil de navegar, priorizando la lectura de datos, el filtrado de información y la gestión de tablas.

## 🔒 Consideraciones de Seguridad

* **Autenticación:** Implementar autenticación segura para todos los roles de usuario.
* **Protección de Datos:** Asegurar que los datos sensibles de los usuarios y las transacciones estén debidamente protegidos y cifrados.
* **Webhooks:** Proteger los endpoints que reciben los Webhooks de Mercado Pago para evitar accesos no autorizados.

## ⏳ Fases o Hitos de Desarrollo (Enfoque MVP)

1.  **Fase 1: Aplicación para Clientes y Trabajadores (MVP)**
    * Configuración del proyecto Flutter y Firebase.
    * Implementación de la autenticación.
    * Creación de las interfaces para clientes y trabajadores.
    * Integración con la API de Mercado Pago y gestión de Webhooks.
    * Configuración de Firebase Cloud Messaging para las notificaciones.
    * Implementación de la lógica de asignación de pedidos.
2.  **Fase 2: Panel de Administración Web**
    * Creación del dashboard de gestión.
    * Implementación de la gestión de promociones, usuarios y supervisión de pedidos.
3.  **Fase 3: Expansión Futura**
    * Desarrollo de la versión web para clientes.
    * Inclusión de nuevos servicios y funcionalidades.

## 🚧 Posibles Desafíos y Soluciones

* **Desafío:** La correcta gestión de los Webhooks de Mercado Pago para asegurar que un pago se registre de forma fiable y a tiempo.
* **Solución:** Desarrollar un endpoint de backend robusto y un sistema de reintentos en caso de fallos temporales.

* **Desafío:** La lógica para que solo el primer trabajador acepte un pedido sin conflictos.
* **Solución:** Utilizar una operación atómica en la base de datos (como una transacción) para asegurar que la asignación del pedido sea un evento único y sin duplicados.

## 📈 Posibilidades de Expansión Futura

* **Nuevos Servicios:** Integrar más servicios financieros o digitales.
* **Múltiples Pasarelas de Pago:** Ofrecer diferentes opciones de pago además de Mercado Pago.
* **Chat en la App:** Un chat para que los clientes y trabajadores se comuniquen directamente.
* **Sistema de Reseñas:** Un sistema para que los clientes califiquen a los trabajadores.
* **Analíticas:** Integración de herramientas de análisis para obtener insights del comportamiento de los usuarios.

---

Este archivo contiene el plan maestro del proyecto appMovilTest.