import 'package:flutter/material.dart';

class RemesasPage extends StatelessWidget {
  final Map<String, dynamic>? package;
  const RemesasPage({Key? key, this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Remesas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Opciones de remesas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            if (package != null) ...[
              Text('Paquete seleccionado: ${package!['label']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
            ],
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text('Enviar 50 USD')),
                  ListTile(title: Text('Enviar 100 USD')),
                  ListTile(title: Text('Enviar 250 USD')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
