import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Admin')),
      body: const Center(
        child: Text('Bienvenido, administrador!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
