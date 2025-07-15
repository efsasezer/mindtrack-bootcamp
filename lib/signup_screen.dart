import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';  // LoginScreen'e yönlendirme için import edin

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Firebase ile kullanıcı kaydı yapma
  void signUp() async {
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    try {
      // Firebase Authentication ile kullanıcı kaydı
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Başarılı kayıttan sonra LoginScreen'e yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),  // Kayıt işlemi başarılı, LoginScreen'e yönlendiriyoruz
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Sign up failed';
      if (e.code == 'weak-password') {
        message = 'Şifre çok zayıf';
      } else if (e.code == 'email-already-in-use') {
        message = 'Bu e-posta zaten kullanılıyor';
      } else if (e.code == 'invalid-email') {
        message = 'Geçersiz e-posta adresi';
      } else {
        message = 'Sign up failed: [${e.code}] ${e.message}';
      }
      // Hata mesajını ekranda göstermek için SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign up to get started',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Email TextField
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Color(0xFF7B7B7B), fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: const Color(0xFFE9ECF5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Color(0xFF7B7B7B), fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: const Color(0xFFE9ECF5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Confirm Password TextField
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(color: Color(0xFF7B7B7B), fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: const Color(0xFFE9ECF5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: signUp,  // Sign Up işlemi
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Already have an account? Login Text
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // LoginScreen'e geri dön
                  },
                  child: const Text(
                    'Already have an account? Log In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
