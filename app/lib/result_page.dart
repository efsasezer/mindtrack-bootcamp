import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Sonuçlarım")),
        body: Center(child: Text("Giriş yapmış bir kullanıcı bulunamadı.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Geçmiş Anket Sonuçlarım"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('depression_responses')
            .where('uid', isEqualTo: user.uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return Center(child: Text('Hiç sonuç bulunamadı.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final result = data['prediction'] == 1 ? 'Depressed' : 'Not Depressed';
              final recommendations = data['recommendations'] ?? 'Yok';

              return Card(
                margin: EdgeInsets.all(12),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sonuç: $result", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      Text("Öneriler:", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text(recommendations, style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
