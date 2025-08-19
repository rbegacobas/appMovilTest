/*
 Node script to update all documents in the 'usuarios' collection.
 - Adds fields if missing: nombre (''), celular (''), updatedAt (server timestamp)
 - Safe by default: set DRY_RUN=1 to do a dry run (no writes). To actually write set DRY_RUN=0.

 Requirements:
 1) Install dependencies: npm install firebase-admin
 2) Provide Google service account JSON and set env var:
    export GOOGLE_APPLICATION_CREDENTIALS="/path/to/serviceAccountKey.json"
 3) Run: node update_users.js

 Note: Script uses Application Default Credentials via GOOGLE_APPLICATION_CREDENTIALS.
*/

const admin = require('firebase-admin');

const DRY_RUN = process.env.DRY_RUN !== '0'; // default true

try {
  admin.initializeApp({
    credential: admin.credential.applicationDefault(),
  });
} catch (e) {
  // allow multiple runs in same process
}

const db = admin.firestore();

async function run() {
  console.log('Starting update_users.js (DRY_RUN=' + (DRY_RUN ? '1' : '0') + ')');
  const usuariosRef = db.collection('usuarios');
  const snapshot = await usuariosRef.get();
  console.log('Found', snapshot.size, 'users');

  let updated = 0;
  for (const doc of snapshot.docs) {
    const data = doc.data();
    const updates = {};
    if (!('nombre' in data)) updates.nombre = '';
    if (!('celular' in data)) updates.celular = '';
    updates.updatedAt = admin.firestore.FieldValue.serverTimestamp();

    // Skip if only updatedAt would change and you want to keep timestamps untouched in dry-run
    const keysToWrite = Object.keys(updates);
    if (keysToWrite.length === 0) continue;

    console.log(`Doc ${doc.id} -> will update:`, updates);
    if (!DRY_RUN) {
      await doc.ref.set(updates, { merge: true });
      updated++;
    }
  }

  console.log(`Done. Documents that would be/was updated: ${DRY_RUN ? 'N/A (dry-run) -> see logs' : updated}`);
}

run().catch(err => {
  console.error('Script failed:', err);
  process.exit(1);
});
