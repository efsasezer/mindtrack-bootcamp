import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hoş Geldiniz',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Anket Butonu
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/anket');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 4,
                shadowColor: Colors.black12,
              ),
              child: const Text(
                'Anket',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),

            // Tavsiye Butonu (placeholder)
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tavsiye');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 4,
                shadowColor: Colors.black12,
              ),
              child: const Text(
                'Tavsiye',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),

            // Takip Butonu (placeholder)
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/takip');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 4,
                shadowColor: Colors.black12,
              ),
              child: const Text(
                'Takip',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF6C63FF), size: 30),
                tooltip: 'Chatbot',
                onPressed: () {
                  Navigator.pushNamed(context, '/chatbot');
                },
              ),
              IconButton(
                icon: const Icon(Icons.home, color: Color(0xFF6C63FF), size: 30),
                tooltip: 'Ana Sayfa',
                onPressed: () {
                  // Zaten ana sayfadayız
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Color(0xFF6C63FF), size: 30),
                tooltip: 'Profil',
                onPressed: () {
                  Navigator.pushNamed(context, '/profil');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}