import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String orderId;
  const PaymentPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pago')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Procesando pago para orden: $orderId'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Simulate payment success and navigate to home
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pago simulado exitoso')));
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Simular pago exitoso'),
            ),
          ],
        ),
      ),
    );
  }
}
