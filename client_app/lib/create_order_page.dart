import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'payment_page.dart';

class CreateOrderPage extends StatefulWidget {
  final String serviceId;
  final Map<String, dynamic>? package;
  const CreateOrderPage({Key? key, required this.serviceId, this.package}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  bool usePackage = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.package != null) {
      _amountController.text = widget.package!['amount']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _proceed() async {
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Necesitas iniciar sesión.')));
      Navigator.of(context).pushReplacementNamed('/');
      return;
    }

    setState(() => _loading = true);
    try {
      final monto = double.tryParse(_amountController.text.trim()) ?? 0.0;
      final docRef = await FirebaseFirestore.instance.collection('ordenes').add({
        'tipoServicio': widget.serviceId,
        'packageLabel': usePackage ? (widget.package != null ? widget.package!['label'] : null) : null,
        'monto': monto,
        'estado': 'pendiente',
        'usuarioId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PaymentPage(orderId: docRef.id)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creando pedido: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.serviceId == 'recargas' ? 'Crear pedido - Recargas' : 'Crear pedido - Remesas';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.package != null) ...[
                Text('Paquete seleccionado: ${widget.package!['label']}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Radio<bool>(value: true, groupValue: usePackage, onChanged: (v) => setState(() => usePackage = true)),
                  const SizedBox(width: 4),
                  const Text('Usar paquete'),
                  const SizedBox(width: 16),
                  Radio<bool>(value: false, groupValue: usePackage, onChanged: (v) => setState(() => usePackage = false)),
                  const SizedBox(width: 4),
                  const Text('Monto personalizado'),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Monto (USD)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  final val = double.tryParse(v ?? '');
                  if (val == null || val <= 0) return 'Ingresa un monto válido';
                  return null;
                },
                enabled: !usePackage || widget.package == null,
              ),
              const SizedBox(height: 16),
              _loading ? const Center(child: CircularProgressIndicator()) : ElevatedButton(
                onPressed: () => _proceed(),
                child: const Text('Proceder al pago'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
