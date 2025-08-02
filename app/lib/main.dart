import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
import 'depression_form_screen.dart';
import 'chatbot_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:FirebaseOptions(
    apiKey: "AIzaSyDn3j-fsQQiuVNbkYeM9A5_VIGQJ5aQYls", 
    appId: "1:264491457827:web:4235c7806173f7c34c0096", 
    messagingSenderId: "264491457827", 
    projectId: "bootcamp-228fc"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
      routes: {
        '/chatbot': (context) => const ChatbotPage(), // 🔄 Burayı güncelle
      }
    );
  }
}