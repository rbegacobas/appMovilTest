import 'package:flutter/material.dart';
import 'recargas_page.dart';
import 'remesas_page.dart';
import 'strings.dart';

class ServiceSelectionPage extends StatelessWidget {
  const ServiceSelectionPage({Key? key}) : super(key: key);

  static final _services = [
    {'id': 'recargas', 'title': Strings.recargas, 'icon': Icons.phone_android},
    {'id': 'remesas', 'title': Strings.remesas, 'icon': Icons.receipt_long},
  ];

  // Predefined packages for demo purposes
  static const Map<String, List<Map<String, dynamic>>> _packages = {
    'recargas': [
      {'label': '5 USD', 'amount': 5},
      {'label': '10 USD', 'amount': 10},
      {'label': '20 USD', 'amount': 20},
    ],
    'remesas': [
      {'label': 'Enviar 50 USD', 'amount': 50},
      {'label': 'Enviar 100 USD', 'amount': 100},
      {'label': 'Enviar 250 USD', 'amount': 250},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar servicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.chooseService, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            // Make grid height responsive to avoid overflow on small screens
            LayoutBuilder(builder: (context, constraints) {
              final gridHeight = (constraints.maxHeight > 400) ? 180.0 : constraints.maxHeight * 0.2;
              return SizedBox(
                height: gridHeight,
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _services.map((s) {
                    return Semantics(
                      label: 'Servicio ${s['title']}',
                      button: true,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the service-specific page
                          if (s['id'] == 'recargas') {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RecargasPage()));
                          } else if (s['id'] == 'remesas') {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RemesasPage()));
                          }
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(s['icon'] as IconData, size: 42, color: Theme.of(context).colorScheme.primary, semanticLabel: s['title'] as String),
                              const SizedBox(height: 12),
                              Text(s['title'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
            const SizedBox(height: 18),
            Text(Strings.recommendedPackages, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: _packages.entries.map((entry) {
                  final serviceId = entry.key;
                  final list = entry.value;
                  return ExpansionTile(
                    title: Text(serviceId == 'recargas' ? '${Strings.recargas} - ${Strings.packages}' : '${Strings.remesas} - ${Strings.packages}'),
                    children: list.map((pkg) {
                      final valid = pkg.containsKey('amount') && (pkg['amount'] is num) && (pkg['amount'] > 0);
                      return ListTile(
                        title: Text(pkg['label'].toString()),
                        trailing: Semantics(
                          button: true,
                          label: '${Strings.select} ${pkg['label']}',
                          child: ElevatedButton(
                            onPressed: valid
                                ? () {
                                    // Provide feedback and navigate
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${Strings.selected}: ${pkg['label']}')));
                                    if (serviceId == 'recargas') {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => RecargasPage(package: pkg)));
                                    } else {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => RemesasPage(package: pkg)));
                                    }
                                  }
                                : null,
                            child: Text(Strings.select),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
