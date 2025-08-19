import 'package:flutter/material.dart';
import 'create_order_page.dart';

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
                children: [
                  ListTile(
                    title: const Text('Enviar 50 USD'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'remesas', package: {'label':'Enviar 50 USD','amount':50})));
                      },
                      child: const Text('Seleccionar'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Enviar 100 USD'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'remesas', package: {'label':'Enviar 100 USD','amount':100})));
                      },
                      child: const Text('Seleccionar'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Enviar 250 USD'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'remesas', package: {'label':'Enviar 250 USD','amount':250})));
                      },
                      child: const Text('Seleccionar'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Monto personalizado'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderPage(serviceId: 'remesas')));
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
