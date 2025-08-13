/// Modelo de pedido para Flutter y Firestore
/// Firestore: Collection 'pedidos'
/// Campos: id, usuarioId, monto, estado, fecha, tipoServicio

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String usuarioId;
  final double monto;
  final String estado;
  final DateTime fecha;
  final String tipoServicio;

  OrderModel({
    required this.id,
    required this.usuarioId,
    required this.monto,
    required this.estado,
    required this.fecha,
    required this.tipoServicio,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      id: id,
      usuarioId: map['usuarioId'] ?? '',
      monto: (map['monto'] ?? 0).toDouble(),
      estado: map['estado'] ?? 'pendiente',
  fecha: map['fecha'] != null ? (map['fecha'] is Timestamp ? (map['fecha'] as Timestamp).toDate() : map['fecha']) : DateTime.now(),
      tipoServicio: map['tipoServicio'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'monto': monto,
      'estado': estado,
      'fecha': fecha,
      'tipoServicio': tipoServicio,
    };
  }
}
