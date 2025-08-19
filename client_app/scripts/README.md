# scripts/update_users.js

This folder contains a helper Node script to update the `usuarios` collection in Firestore by adding missing fields (`nombre`, `celular`) and setting `updatedAt` to server timestamp.

How to run (safe):

1. Install Node deps:

```bash
cd client_app/scripts
npm init -y
npm install firebase-admin
```

2. Provide Google service account JSON and export env var:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/serviceAccountKey.json"
```

3. Dry run (no writes):

```bash
DRY_RUN=1 node update_users.js
```

4. To apply changes (write to Firestore):

```bash
DRY_RUN=0 node update_users.js
```

Notes:
- The script uses Application Default Credentials. Make sure the service account has access to Firestore.
- You can adapt the script to add more fields or transformations as required.
