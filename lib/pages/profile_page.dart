import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peach_pulse/pages/login_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil'), centerTitle: true),
      body:
          user == null
              ? const Center(child: Text('No hay usuario logueado.'))
              : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/Ariana Grande.jpg',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.displayName ?? 'Usuario sin nombre',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email ?? 'Correo no disponible',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    // Puedes agregar más campos aquí si los tienes
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ); // o tu ruta de login
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Cerrar sesión'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
