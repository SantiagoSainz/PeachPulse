import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peach_pulse/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _error;

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundWaves(),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),

                // logo
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/images/ChatGPT Image.png',
                  ),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),

                // App Name
                Text(
                  "Peach",
                  style: TextStyle(
                    fontFamily: "Quicksand-VariableFont_wght",
                    fontSize: 28,
                    color: Colors.deepOrangeAccent[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Pulse",
                  style: TextStyle(
                    fontFamily: "Quicksand-VariableFont_wght",
                    fontSize: 28,
                    color: Colors.greenAccent[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 40),

                // Phone Input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: (Colors.pink[100] ?? Colors.pink).withOpacity(
                        0.3,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 40,
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: (Colors.pink[100] ?? Colors.pink).withOpacity(
                        0.3,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 30),

                //SignIn button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {
                    _login();
                  },
                  child: const Text(
                    "Sign In ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundWaves extends StatelessWidget {
  const _BackgroundWaves();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFEE4E4), Color(0xFFFEDCDC), Color(0xFFFEC6DA)],
        ),
      ),
    );
  }
}
