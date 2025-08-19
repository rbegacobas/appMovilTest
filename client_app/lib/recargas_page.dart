import 'package:flutter/material.dart';
import 'create_order_page.dart';

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
                children: [
                  ListTile(
                    title: const Text('Recarga - 5 USD'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'recargas', package: {'label':'5 USD','amount':5})));
                      },
                      child: const Text('Seleccionar'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Recarga - 10 USD'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'recargas', package: {'label':'10 USD','amount':10})));
                      },
                      child: const Text('Seleccionar'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Recarga - 20 USD'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'recargas', package: {'label':'20 USD','amount':20})));
                      },
                      child: const Text('Seleccionar'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Monto personalizado'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'recargas')));
                      },
                      child: const Text('Ingresar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
