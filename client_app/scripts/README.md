update_users.js - migración para la colección `usuarios`
=====================================================

Descripción
-----------
Script Node para agregar/normalizar campos en los documentos de la colección `usuarios`:

- `nombreCompleto` (toma `nombre` o `displayName` si existe)
- `celular` (toma `celular` o `phone` si existe)
- `updatedAt` (serverTimestamp)

Uso
---

Modo dry-run (predeterminado, no escribe):

```bash
node update_users.js --limit 5
```

Aplicar cambios (con credenciales configuradas):

```bash
node update_users.js --apply --limit 100
```

Credenciales
-----------
El script usa Application Default Credentials (ADC). Dos opciones:

1) Exportar una clave de servicio antes de ejecutar:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/ruta/a/service-account.json"
```

2) Usar gcloud locally:

```bash
gcloud auth application-default login
```

Precauciones
-----------
- Hacer backup antes de aplicar. El dry-run muestra exactamente qué se actualizaría.
- Testear primero con `--limit 5` para revisar los cambios.
