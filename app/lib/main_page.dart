import 'package:flutter/material.dart';
import 'depression_form_screen.dart';
import 'chatbot_page.dart';
import 'result_page.dart';
import 'profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruh Sağlığı Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Seçili sayfa indexini tutar

  // Sayfalarımızı bir liste içinde tanımlıyoruz.
  // MainPage'in state'inde kalmalı ki, BottomNavigationBar ile yönetilebilsin.
  final List<Widget> _pages = [
    const HomePageContent(),
    const ChatbotPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: _pages[_selectedIndex], // Seçili sayfayı gösterir
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Ana sayfa içeriğini ayrı bir widget'a taşıdım
class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  // recommendations listesini doğrudan buraya kopyaladık
  static const List<String> recommendations = [
    "Güne başlarken derin bir nefes al ve kendine iyi davran.",
    "Küçük de olsa bir hedef belirle, tamamladığında kendini takdir et.",
    "Bugün kendin için 10 dakikalık yürüyüş ayır.",
    "Negatif düşünceleri fark et ve yargılamadan kabul et.",
    "Sana iyi gelen bir müzik aç ve dinlen.",
    "Gün içinde birine teşekkür et.",
    "Duygularını yazabileceğin kısa bir günlük tut.",
    "Ekran süreni azaltmak için 1 saatlik mola planla.",
    "Sağlıklı bir içecek hazırla ve kendine zaman ayır.",
    "Bugün kendine en az 1 kez gülümsediğini hatırlat.",
  ];

  int waterCount = 0;
  int walkingMinutes = 0;
  final TextEditingController _walkController = TextEditingController();

  @override
  void dispose() {
    _walkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String todayRecommendation =
        recommendations[now.day % recommendations.length];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Hoş Geldiniz'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRecommendationCard(todayRecommendation),
            const SizedBox(height: 24),
            _buildActionButton(
              context,
              'Anketi Yap',
              Colors.indigo,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DepressionForm()),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              context,
              'Anket Sonuçlarım',
              Colors.indigo.withOpacity(0.1),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResultsPage()),
                );
              },
              textColor: Colors.indigo,
              isFilled: false,
            ),
            const SizedBox(height: 24),
            const Text(
              "Günlük Alışkanlık Takibi",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildHabitCard(
              title: "Su Tüketimi",
              icon: Icons.local_drink_rounded,
              value: "$waterCount bardak",
              onTap: () {
                setState(() {
                  waterCount++;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildWalkingCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String text) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Bugünün Tavsiyesi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onPressed, {
    Color textColor = Colors.white,
    bool isFilled = true,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? color : Colors.transparent,
        foregroundColor: isFilled ? Colors.white : color,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isFilled
              ? BorderSide.none
              : BorderSide(color: color, width: 1.5),
        ),
        elevation: isFilled ? 4 : 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: isFilled ? FontWeight.w600 : FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildHabitCard({
    required String title,
    required IconData icon,
    required String value,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.indigo),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (onTap != null)
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(100),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add_circle, color: Colors.indigo, size: 30),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWalkingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.directions_walk, color: Colors.indigo),
              ),
              const SizedBox(width: 16),
              const Text(
                "Yürüyüş Süresi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _walkController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Dakika girin",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    walkingMinutes = int.tryParse(_walkController.text) ?? 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text("Kaydet"),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Bugünkü yürüyüş: $walkingMinutes dk",
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}