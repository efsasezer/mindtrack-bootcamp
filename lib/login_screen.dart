import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'survey_page.dart';  // Burada SurveyPage'i import edin.
import 'signup_screen.dart'; // SignUpScreen'i ekledim

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase Auth ile giriş işlemi
  void login() async {
    try {
      // Firebase Authentication ile giriş yapma
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Başarıyla giriş yaptıysa SurveyPage'e yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SurveyPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';
      // Hata kodlarına göre mesajları özelleştirme
      if (e.code == 'user-not-found') {
        message = 'Email bulunamadı.';
      } else if (e.code == 'wrong-password') {
        message = 'Şifre hatalı.';
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
                  'Log in to continue',
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
                const SizedBox(height: 8),
                // Forgot password button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password işlemi
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: login,  // Giriş işlemi başlat
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Sign Up Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
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
