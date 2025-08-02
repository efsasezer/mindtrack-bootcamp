import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class DepressionForm extends StatefulWidget {
  @override
  _DepressionFormState createState() => _DepressionFormState();
}

class _DepressionFormState extends State<DepressionForm>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  int? gender;
  double? age;
  int? profession = 11; // Sabit: Öğrenci
  double? academicPressure;
  double? cgpa;
  double? studySatisfaction;
  int? sleepDuration;
  int? dietaryHabits;
  int? degree;
  int? suicidalThoughts;
  double? workStudyHours;
  double? financialStress;
  int? familyHistory;

  String? result;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;
  _formKey.currentState!.save();

  setState(() {
    isLoading = true;
    result = null;
  });

  final body = jsonEncode({
    "Gender": gender,
    "Age": age,
    "Profession": profession,
    "Academic_Pressure": academicPressure,
    "CGPA": cgpa,
    "Study_Satisfaction": studySatisfaction,
    "Sleep_Duration": sleepDuration,
    "Dietary_Habits": dietaryHabits,
    "Degree": degree,
    "Suicidal_Thoughts": suicidalThoughts,
    "Work_Study_Hours": workStudyHours,
    "Financial_Stress": financialStress,
    "Family_History": familyHistory
  });

  try {
    final uri = Uri.parse("http://192.168.0.18:8000/predict");
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        result = data['recommendations'] ?? 'Öneri alınamadı.';
        isLoading = false;
      });

      // ✅ Kullanıcıyı al
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('depression_responses').add({
          'uid': user.uid,
          'gender': gender,
          'age': age,
          'profession': profession,
          'academicPressure': academicPressure,
          'cgpa': cgpa,
          'studySatisfaction': studySatisfaction,
          'sleepDuration': sleepDuration,
          'dietaryHabits': dietaryHabits,
          'degree': degree,
          'suicidalThoughts': suicidalThoughts,
          'workStudyHours': workStudyHours,
          'financialStress': financialStress,
          'familyHistory': familyHistory,
          'prediction': data['result'],
          'recommendations': data['recommendations'],
          'timestamp': DateTime.now(),
        });
      }

      _animationController.forward();
      _showResultDialog(data);
    } else {
      setState(() {
        result = "Sunucu hatası: ${response.statusCode}";
        isLoading = false;
      });
    }
  } catch (e) {
    setState(() {
      result = "Bağlantı hatası: $e";
      isLoading = false;
    });
  }
}


  void _showResultDialog(Map<String, dynamic> data) {
    final isDepressed = data['result'] == 'Depressed';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 16,
          child: Container(
            constraints: BoxConstraints(maxHeight: 600),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDepressed
                    ? [Colors.orange[50]!, Colors.red[50]!]
                    : [Colors.green[50]!, Colors.blue[50]!],
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sonuç İkonu
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isDepressed ? Colors.orange[100] : Colors.green[100],
                      boxShadow: [
                        BoxShadow(
                          color: (isDepressed ? Colors.orange : Colors.green)
                              .withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      isDepressed ? Icons.psychology_outlined : Icons.mood,
                      size: 40,
                      color:
                          isDepressed ? Colors.orange[700] : Colors.green[700],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Başlık
                  Text(
                    isDepressed ? "Dikkat Gerekiyor" : "Harika Durumdasın!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                          isDepressed ? Colors.orange[800] : Colors.green[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),

                  // Alt Başlık
                  Text(
                    isDepressed
                        ? "Seninle birlikte bu durumu aşacağız"
                        : "Ruh sağlığın için bu önerileri takip et",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),

                  // Öneriler
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        data['recommendations'] ?? 'Öneri alınamadı.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Butonlar
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _animationController.reset();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              color: isDepressed ? Colors.orange : Colors.green,
                            ),
                          ),
                          child: Text(
                            "Kapat",
                            style: TextStyle(
                              color: isDepressed
                                  ? Colors.orange[700]
                                  : Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _resetForm();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDepressed ? Colors.orange : Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            "Yeni Test",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _resetForm() {
    setState(() {
      gender = null;
      age = null;
      profession = 11; // Sabit: Öğrenci
      academicPressure = null;
      cgpa = null;
      studySatisfaction = null;
      sleepDuration = null;
      dietaryHabits = null;
      degree = null;
      suicidalThoughts = null;
      workStudyHours = null;
      financialStress = null;
      familyHistory = null;
      result = null;
    });
    _formKey.currentState?.reset();
    _animationController.reset();
  }

  Widget _buildDropdown<T>(String label, T? value,
      List<DropdownMenuItem<T>> items, void Function(T?) onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        value: value,
        items: items,
        onChanged: onChanged,
        validator: (val) => val == null ? 'Lütfen seçim yapın' : null,
      ),
    );
  }

  Widget _buildNumberInput(String label, void Function(String?) onSaved) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        keyboardType: TextInputType.number,
        validator: (val) =>
            val == null || val.isEmpty ? 'Boş bırakılamaz' : null,
        onSaved: onSaved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Ruh Sağlığı Analizi",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Başlık Kartı
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.blue],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.psychology,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Ruh Sağlığın Önemli",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lütfen soruları dürüstçe yanıtlayın",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              // Form Alanları
              _buildDropdown(
                "Cinsiyet",
                gender,
                [
                  DropdownMenuItem(value: 0, child: Text("Kadın")),
                  DropdownMenuItem(value: 1, child: Text("Erkek")),
                ],
                (val) => setState(() => gender = val),
              ),
              _buildNumberInput(
                  "Yaş", (val) => age = double.tryParse(val ?? '')),
              _buildDropdown(
                "Uyku Süresi",
                sleepDuration,
                [
                  DropdownMenuItem(value: 0, child: Text("5-6 saat")),
                  DropdownMenuItem(value: 1, child: Text("7-8 saat")),
                  DropdownMenuItem(value: 2, child: Text("5 saatten az")),
                  DropdownMenuItem(value: 3, child: Text("8 saatten fazla")),
                  DropdownMenuItem(value: 4, child: Text("Diğer")),
                ],
                (val) => setState(() => sleepDuration = val),
              ),
              _buildDropdown(
                "Beslenme Alışkanlığı",
                dietaryHabits,
                [
                  DropdownMenuItem(value: 0, child: Text("Sağlıklı")),
                  DropdownMenuItem(value: 1, child: Text("Orta")),
                  DropdownMenuItem(value: 2, child: Text("Diğer")),
                  DropdownMenuItem(value: 3, child: Text("Sağlıksız")),
                ],
                (val) => setState(() => dietaryHabits = val),
              ),
              _buildDropdown(
                "Eğitim Seviyesi",
                degree,
                [
                  DropdownMenuItem(value: 0, child: Text("B.Arch (Mimarlık)")),
                  DropdownMenuItem(value: 1, child: Text("B.Com (Ticaret)")),
                  DropdownMenuItem(value: 2, child: Text("B.Ed (Eğitim)")),
                  DropdownMenuItem(
                      value: 3, child: Text("B.Pharm (Eczacılık)")),
                  DropdownMenuItem(
                      value: 4, child: Text("B.Tech (Mühendislik)")),
                  DropdownMenuItem(value: 5, child: Text("BA (Sanat)")),
                  DropdownMenuItem(value: 6, child: Text("BBA (İşletme)")),
                  DropdownMenuItem(value: 7, child: Text("BCA (Bilgisayar)")),
                  DropdownMenuItem(value: 8, child: Text("BE (Mühendislik)")),
                  DropdownMenuItem(value: 9, child: Text("BHM (Otelcilik)")),
                  DropdownMenuItem(
                      value: 10, child: Text("BSc (Fen Bilimleri)")),
                  DropdownMenuItem(value: 11, child: Text("Lise Mezunu")),
                  DropdownMenuItem(value: 12, child: Text("LLB (Hukuk)")),
                  DropdownMenuItem(value: 13, child: Text("LLM (Y.L. Hukuk)")),
                  DropdownMenuItem(
                      value: 14, child: Text("M.Com (Y.L. Ticaret)")),
                  DropdownMenuItem(
                      value: 15, child: Text("M.Ed (Y.L. Eğitim)")),
                  DropdownMenuItem(
                      value: 16, child: Text("M.Pharm (Y.L. Eczacılık)")),
                  DropdownMenuItem(
                      value: 17, child: Text("M.Tech (Y.L. Mühendislik)")),
                  DropdownMenuItem(value: 18, child: Text("MA (Y.L. Sanat)")),
                  DropdownMenuItem(value: 19, child: Text("MBA")),
                  DropdownMenuItem(value: 20, child: Text("MBBS (Tıp)")),
                  DropdownMenuItem(
                      value: 21, child: Text("MCA (Y.L. Bilgisayar)")),
                  DropdownMenuItem(value: 22, child: Text("MD (Tıp Doktoru)")),
                  DropdownMenuItem(
                      value: 23, child: Text("ME (Y.L. Mühendislik)")),
                  DropdownMenuItem(
                      value: 24, child: Text("MHM (Y.L. Otelcilik)")),
                  DropdownMenuItem(
                      value: 25, child: Text("MSc (Y.L. Fen Bilimleri)")),
                  DropdownMenuItem(value: 26, child: Text("Diğer")),
                  DropdownMenuItem(value: 27, child: Text("PhD (Doktora)")),
                ],
                (val) => setState(() => degree = val),
              ),
              _buildDropdown(
                "İntihar Düşüncesi",
                suicidalThoughts,
                [
                  DropdownMenuItem(value: 0, child: Text("Hayır")),
                  DropdownMenuItem(value: 1, child: Text("Evet")),
                ],
                (val) => setState(() => suicidalThoughts = val),
              ),
              _buildNumberInput("Akademik Baskı (1-5)",
                  (val) => academicPressure = double.tryParse(val ?? '')),
              _buildNumberInput(
                  "CGPA (0-10)", (val) => cgpa = double.tryParse(val ?? '')),
              _buildNumberInput("Öğrenim Memnuniyeti (1-5)",
                  (val) => studySatisfaction = double.tryParse(val ?? '')),
              _buildNumberInput("Çalışma / Ders Saati",
                  (val) => workStudyHours = double.tryParse(val ?? '')),
              _buildNumberInput("Finansal Stres (1-5)",
                  (val) => financialStress = double.tryParse(val ?? '')),
              _buildDropdown(
                "Ailede Ruhsal Hastalık Geçmişi",
                familyHistory,
                [
                  DropdownMenuItem(value: 0, child: Text("Hayır")),
                  DropdownMenuItem(value: 1, child: Text("Evet")),
                ],
                (val) => setState(() => familyHistory = val),
              ),

              SizedBox(height: 30),

              // Analiz Et Butonu
              Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.blue],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Analiz Ediliyor...",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "Analiz Et",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}