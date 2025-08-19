import 'package:flutter/material.dart';

class RecargasPage extends StatelessWidget {
  final Map<String, dynamic>? package;
  const RecargasPage({Key? key, this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recargas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recargas disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            if (package != null) ...[
              Text('Paquete seleccionado: ${package!['label']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
            ],
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text('Recarga - 5 USD')),
                  ListTile(title: Text('Recarga - 10 USD')),
                  ListTile(title: Text('Recarga - 20 USD')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
