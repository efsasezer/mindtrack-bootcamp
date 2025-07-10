import 'package:flutter/material.dart';

void main() {
  runApp(SoruUygulamasi());
}

class SoruUygulamasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soru Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        primarySwatch: Colors.indigo,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: SoruSayfasi(),
    );
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  int _soruIndex = 0;
  final Map<String, dynamic> cevaplar = {};
  final TextEditingController _text1 = TextEditingController();
  final TextEditingController _text2 = TextEditingController();

  void sonraki(dynamic cevap) {
    if (cevap != null) {
      cevaplar["Soru ${_soruIndex + 1}"] = cevap;
    }
    _text1.clear();
    _text2.clear();
    setState(() => _soruIndex++);
  }

  Widget soruKarti(Widget child) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(padding: const EdgeInsets.all(24.0), child: child),
    );
  }

  Widget soruWidget() {
    switch (_soruIndex) {
      case 0:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Ad ve Soyad",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _text1,
                decoration: InputDecoration(hintText: "Ad Soyad"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => sonraki(_text1.text),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 1:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2. Yaş",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _text1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Yaş"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => sonraki(_text1.text),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 2:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "3. Cinsiyet",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...["Kadın", "Erkek", "Diğer"].map(
                (secenek) => RadioListTile(
                  title: Text(secenek),
                  value: secenek,
                  groupValue: cevaplar["Soru 3"],
                  onChanged: (val) => setState(() => cevaplar["Soru 3"] = val),
                ),
              ),
              ElevatedButton(
                onPressed: () => sonraki(cevaplar["Soru 3"]),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 3:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "4. Okul ve Bölüm",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _text1,
                decoration: InputDecoration(hintText: "Okul"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _text2,
                decoration: InputDecoration(hintText: "Bölüm"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => sonraki("${_text1.text} - ${_text2.text}"),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 4:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ekstralar",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 10),
              Text(
                "5. Sosyal Medyada Geçirilen Süre",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...["0-2", "2-4", "4-6", ">6"].map(
                (secenek) => RadioListTile(
                  title: Text("$secenek saat"),
                  value: secenek,
                  groupValue: cevaplar["Soru 5"],
                  onChanged: (val) => setState(() => cevaplar["Soru 5"] = val),
                ),
              ),
              ElevatedButton(
                onPressed: () => sonraki(cevaplar["Soru 5"]),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 5:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "6. Sigara ve Alkol Kullanımı",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...["Sigara", "Alkol", "Sigara ve Alkol", "Hiçbiri"].map(
                (secenek) => RadioListTile(
                  title: Text(secenek),
                  value: secenek,
                  groupValue: cevaplar["Soru 6"],
                  onChanged: (val) => setState(() => cevaplar["Soru 6"] = val),
                ),
              ),
              ElevatedButton(
                onPressed: () => sonraki(cevaplar["Soru 6"]),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 6:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "7. Egzersiz Sıklığı",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...["Hiç", "Haftada 1", "Haftada 2", "Haftada 3+"].map(
                (secenek) => RadioListTile(
                  title: Text(secenek),
                  value: secenek,
                  groupValue: cevaplar["Soru 7"],
                  onChanged: (val) => setState(() => cevaplar["Soru 7"] = val),
                ),
              ),
              ElevatedButton(
                onPressed: () => sonraki(cevaplar["Soru 7"]),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 7:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "8. Sabah İnsanı mı, Gece Kuşu musun?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...["Sabah İnsanı", "Gece Kuşu"].map(
                (secenek) => RadioListTile(
                  title: Text(secenek),
                  value: secenek,
                  groupValue: cevaplar["Soru 8"],
                  onChanged: (val) => setState(() => cevaplar["Soru 8"] = val),
                ),
              ),
              ElevatedButton(
                onPressed: () => sonraki(cevaplar["Soru 8"]),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 8:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "9. Tek mi yaşıyorsun?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...["Evet", "Hayır"].map(
                (secenek) => RadioListTile(
                  title: Text(secenek),
                  value: secenek,
                  groupValue: cevaplar["Soru 9"],
                  onChanged: (val) => setState(() => cevaplar["Soru 9"] = val),
                ),
              ),
              ElevatedButton(
                onPressed: () => sonraki(cevaplar["Soru 9"]),
                child: Text("İleri"),
              ),
            ],
          ),
        );
      case 9:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "10. Son zamanlarda nasıl hissediyorsun?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...["Çok İyi", "İyi", "Orta", "Kötü", "Çok Kötü"].map(
                (secenek) => RadioListTile(
                  title: Text(secenek),
                  value: secenek,
                  groupValue: cevaplar["Soru 10"],
                  onChanged: (val) => setState(() => cevaplar["Soru 10"] = val),
                ),
              ),
              ElevatedButton(
                onPressed: () => sonraki(cevaplar["Soru 10"]),
                child: Text("Bitir"),
              ),
            ],
          ),
        );
      default:
        return soruKarti(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Teşekkürler!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Cevaplarınız:", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              ...cevaplar.entries.map(
                (e) => Text(
                  "${e.key}: ${e.value}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: soruWidget()));
  }
}
