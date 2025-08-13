/// Modelo de contacto para Flutter y Firestore
/// Firestore: Collection 'contactos'
/// Ejemplo de documento:
/// {
///   "id": "contacto123",
///   "nombre": "Mama",
///   "celulares": [
///     {"numero": "55512345", "alias": "Movil Cuba"}
///   ],
///   "tarjetas": [
///     {"numero": "1234567890123456", "tipo": "CUP", "subtipo": "clasica", "alias": "Bandec", "celularConfirmacion": "55598765"}
///   ]
/// }

class ContactModel {
  final String id;
  final String nombre;
  final List<ContactoCelular> celulares;
  final List<ContactoTarjeta> tarjetas;

  ContactModel({
    required this.id,
    required this.nombre,
    required this.celulares,
    required this.tarjetas,
  });

  factory ContactModel.fromMap(String id, Map<String, dynamic> map) {
    return ContactModel(
      id: id,
      nombre: map['nombre'] ?? '',
      celulares: (map['celulares'] as List<dynamic>? ?? []).map((c) => ContactoCelular.fromMap(c)).toList(),
      tarjetas: (map['tarjetas'] as List<dynamic>? ?? []).map((t) => ContactoTarjeta.fromMap(t)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'celulares': celulares.map((c) => c.toMap()).toList(),
      'tarjetas': tarjetas.map((t) => t.toMap()).toList(),
    };
  }
}

class ContactoCelular {
  final String numero;
  final String alias;

  ContactoCelular({required this.numero, required this.alias});

  factory ContactoCelular.fromMap(Map<String, dynamic> map) {
    return ContactoCelular(
      numero: map['numero'] ?? '',
      alias: map['alias'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'alias': alias,
    };
  }
}

class ContactoTarjeta {
  final String numero;
  final String tipo;
  final String subtipo;
  final String alias;
  final String celularConfirmacion;

  ContactoTarjeta({
    required this.numero,
    required this.tipo,
    required this.subtipo,
    required this.alias,
    required this.celularConfirmacion,
  });

  factory ContactoTarjeta.fromMap(Map<String, dynamic> map) {
    return ContactoTarjeta(
      numero: map['numero'] ?? '',
      tipo: map['tipo'] ?? '',
      subtipo: map['subtipo'] ?? '',
      alias: map['alias'] ?? '',
      celularConfirmacion: map['celularConfirmacion'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'tipo': tipo,
      'subtipo': subtipo,
      'alias': alias,
      'celularConfirmacion': celularConfirmacion,
    };
  }
}
