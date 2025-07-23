import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'survey_page.dart';
import 'main_page.dart';

// Diğer sayfaların importları...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDn3j-fsQQiuVNbkYeM9A5_VIGQJ5aQYls",
      appId: "1:264491457827:web:4235c7806173f7c34c0096",
      messagingSenderId: "264491457827",
      projectId: "bootcamp-228fc",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/anket': (context) => const SurveyPage(),
        '/anasayfa': (context) => const MainPage(),
        // Diğer sayfa rotaları placeholder olabilir
        '/tavsiye': (context) => Scaffold(body: Center(child: Text('Tavsiye Sayfası'))),
        '/takip': (context) => Scaffold(body: Center(child: Text('Takip Sayfası'))),
        '/chatbot': (context) => Scaffold(body: Center(child: Text('Chatbot Sayfası'))),
        '/profil': (context) => Scaffold(body: Center(child: Text('Profil Sayfası'))),
      },
    );
  }
}