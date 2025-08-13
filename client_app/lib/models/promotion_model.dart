/// Modelo de promoción para Flutter y Firestore
/// Firestore: Collection 'promociones'
/// Ejemplo de documento:
/// {
///   "id": "promo123",
///   "titulo": "Promo Recarga",
///   "descripcion": "Recarga y gana...",
///   "fechaInicio": Timestamp,
///   "fechaFin": Timestamp,
///   "activo": true,
///   "tipoServicio": "recarga" // o "remesa", "todos"
/// }

import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  final String id;
  final String titulo;
  final String descripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final bool activo;
  final String tipoServicio;

  PromotionModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.activo,
    required this.tipoServicio,
  });

  factory PromotionModel.fromMap(String id, Map<String, dynamic> map) {
    return PromotionModel(
      id: id,
      titulo: map['titulo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      fechaInicio: map['fechaInicio'] != null ? (map['fechaInicio'] is Timestamp ? (map['fechaInicio'] as Timestamp).toDate() : map['fechaInicio']) : DateTime.now(),
      fechaFin: map['fechaFin'] != null ? (map['fechaFin'] is Timestamp ? (map['fechaFin'] as Timestamp).toDate() : map['fechaFin']) : DateTime.now(),
      activo: map['activo'] ?? false,
      tipoServicio: map['tipoServicio'] ?? 'todos',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio,
      'fechaFin': fechaFin,
      'activo': activo,
      'tipoServicio': tipoServicio,
    };
  }
}
