import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'worker_home_page.dart';
import 'admin_home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  bool _isLogin = true;
  String? _error;
  bool _loading = false;

  Future<void> _submit() async {
    setState(() { _loading = true; _error = null; });
    try {
      if (_isLogin) {
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Validar rol en Firestore
        final doc = await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).get();
        final data = doc.data();
        if (data != null && data['rol'] == 'trabajador') {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const WorkerHomePage()),
            );
          }
        } else if (data != null && data['rol'] == 'cliente') {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        } else if (data != null && data['rol'] == 'admin') {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AdminHomePage()),
            );
          }
        } else {
          // Si no tiene rol válido, mostrar error y cerrar sesión
          await FirebaseAuth.instance.signOut();
          setState(() {
            _error = 'No tienes permisos para acceder.';
          });
        }
      } else {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Guardar datos básicos en Firestore
        await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).set({
          'email': _emailController.text.trim(),
          'nombreCompleto': _nameController.text.trim(),
          'celular': _celularController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'rol': 'cliente',
        });
        // Mostrar mensaje de éxito y navegar a HomePage
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Registro exitoso!')),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _error = 'El email ya está en uso.';
      } else if (e.code == 'weak-password') {
        _error = 'La contraseña es demasiado débil.';
      } else if (e.code == 'invalid-email') {
        _error = 'El email no es válido.';
      } else if (e.code == 'user-not-found') {
        _error = 'Usuario no encontrado.';
      } else if (e.code == 'wrong-password') {
        _error = 'Contraseña incorrecta.';
      } else {
        _error = e.message;
      }
    } catch (e) {
      _error = 'Error inesperado: $e';
    }
    setState(() { _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Iniciar sesión' : 'Registrarse')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v != null && v.contains('@') ? null : 'Email inválido',
                ),
                const SizedBox(height: 16),
                // Nombre y celular solo para registro
                if (!_isLogin) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nombre completo'),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) => !_isLogin && (v == null || v.trim().isEmpty) ? 'Ingresa tu nombre' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _celularController,
                    decoration: const InputDecoration(labelText: 'Celular'),
                    keyboardType: TextInputType.phone,
                    validator: (v) => !_isLogin && (v == null || v.trim().isEmpty) ? 'Ingresa un celular' : null,
                  ),
                  const SizedBox(height: 16),
                ],
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: (v) => v != null && v.length >= 6 ? null : 'Mínimo 6 caracteres',
                ),
                const SizedBox(height: 24),
                if (_error != null) ...[
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                ],
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _submit();
                          }
                        },
                        child: Text(_isLogin ? 'Entrar' : 'Registrarse'),
                      ),
                TextButton(
                  onPressed: () => setState(() => _isLogin = !_isLogin),
                  child: Text(_isLogin ? '¿No tienes cuenta? Regístrate' : '¿Ya tienes cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _celularController.dispose();
    super.dispose();
  }
}
