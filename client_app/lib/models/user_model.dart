/// Modelo de usuario para Flutter y Firestore
/// Firestore: Collection 'usuarios'
/// Campos: uid, email, nombre, rol, createdAt

import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo de usuario para Flutter y Firestore
/// Firestore: Collection 'usuarios'
/// Ejemplo de documento:
/// {
///   "uid": "abc123",
///   "email": "usuario@email.com",
///   "nombre": "Juan Perez",
///   "celular": "5551234567",
///   "rol": "cliente",
///   "createdAt": Timestamp
/// }

class UserModel {
  final String uid;
  final String email;
  final String nombre;
  final String celular;
  final String rol;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.nombre,
    required this.celular,
    required this.rol,
    this.createdAt,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      nombre: map['nombre'] ?? '',
      celular: map['celular'] ?? '',
      rol: map['rol'] ?? 'cliente',
      createdAt: map['createdAt'] != null ? (map['createdAt'] is Timestamp ? (map['createdAt'] as Timestamp).toDate() : map['createdAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nombre': nombre,
      'celular': celular,
      'rol': rol,
      'createdAt': createdAt,
    };
  }
}
