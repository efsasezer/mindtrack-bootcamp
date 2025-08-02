import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int questionIndex = 0;
  final Map<String, String> answers = {};
  final TextEditingController controller = TextEditingController();
  String? dropdownValue;
  String? errorText;
  bool isSubmitting = false;
  String? submitError;

  final List<Map<String, dynamic>> questions = [
    {
      'text': 'Cinsiyetiniz nedir?',
      'type': 'radio',
      'options': ['Kadın', 'Erkek'],
      'key': 'Cinsiyet',
    },
    {'text': 'Yaşınız?', 'type': 'input', 'key': 'Yaş'},
    {
      'text': 'Mesleğiniz / Alanınız:',
      'type': 'dropdown',
      'options': [
        'Architect',
        'Chef',
        'Doctor',
        'Lawyer',
        'Student',
        'Teacher',
      ],
      'key': 'Meslek',
    },
    {
      'text': 'Akademik baskı düzeyiniz (0-10):',
      'type': 'input',
      'key': 'Akademik Baskı',
    },
    {'text': 'Not ortalamanız:', 'type': 'input', 'key': 'Not Ortalaması'},
    {
      'text': 'Eğitimden memnuniyet düzeyiniz (0-10):',
      'type': 'input',
      'key': 'Memnuniyet',
    },
    {
      'text': 'Uyku süreniz:',
      'type': 'dropdown',
      'options': ['5-6 saat', '7-8 saat', '<5 saat', '>8 saat'],
      'key': 'Uyku Süresi',
    },
    {
      'text': 'Beslenme alışkanlığınız:',
      'type': 'dropdown',
      'options': ['Sağlıklı', 'Orta', 'Diğer', 'Sağlıksız'],
      'key': 'Beslenme',
    },
    {
      'text': 'Eğitim dereceniz:',
      'type': 'dropdown',
      'options': ['BSc', 'BA', 'MBA', 'PhD'],
      'key': 'Eğitim Derecesi',
    },
    {
      'text': 'Daha önce intihar düşünceniz oldu mu?',
      'type': 'radio',
      'options': ['Evet', 'Hayır'],
      'key': 'İntihar Düşüncesi',
    },
    {
      'text': 'Günlük ders süreniz (saat):',
      'type': 'input',
      'key': 'Ders Süresi',
    },
    {
      'text': 'Finansal stres düzeyiniz:',
      'type': 'input',
      'key': 'Finansal Stres',
    },
    {
      'text': 'Ailede ruhsal hastalık geçmişi var mı?',
      'type': 'radio',
      'options': ['Evet', 'Hayır'],
      'key': 'Ailede Ruhsal Hastalık',
    },
  ];

  Future<void> next(dynamic value) async {
    final key = questions[questionIndex]['key'];
    answers[key] = value.toString();
    controller.clear();
    dropdownValue = null;
    errorText = null;

    if (questionIndex + 1 >= questions.length) {
      setState(() { isSubmitting = true; submitError = null; });
      try {
        await FirebaseFirestore.instance.collection('user').add(answers);
        setState(() {
          questionIndex++;
          isSubmitting = false;
        });
      } catch (e) {
        setState(() {
          isSubmitting = false;
          submitError = 'Kayıt başarısız: ' + e.toString();
        });
      }
      return;
    }
    setState(() {
      questionIndex++;
    });
  }

  Widget buildProgressBar() {
    double progress = (questionIndex + 1) / questions.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Assessment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "${questionIndex + 1} / ${questions.length}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          minHeight: 6,
          color: Color(0xFF6C63FF),
          backgroundColor: Color(0xFFE0E2F2),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget buildRadioOptions(List options, String key) {
    return Column(
      children: options.map<Widget>((option) {
        final bool isSelected = answers[key] == option;
        return GestureDetector(
          onTap: () {
            setState(() {
              answers[key] = option;
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF6C63FF) : Colors.white,
              border: Border.all(
                color: isSelected ? Color(0xFF6C63FF) : Color(0xFFE0E2F2),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Color(0xFFB0B0B0),
                      width: 2,
                    ),
                    color: isSelected ? Colors.white : Colors.transparent,
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Color(0xFF6C63FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildQuestion() {
    final question = questions[questionIndex];
    final key = question['key'];
    final questionText = Text(
      question['text'],
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );

    switch (question['type']) {
      case 'input':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            questionText,
            SizedBox(height: 24),
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Cevabınızı girin",
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 18),
              ),
              onChanged: (text) {
                setState(() {
                  errorText = text.trim().isEmpty ? "Bu alan boş bırakılamaz." : null;
                });
              },
            ),
            if (errorText != null) ...[
              SizedBox(height: 8),
              Text(
                errorText!,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        );
      case 'radio':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            questionText,
            SizedBox(height: 24),
            buildRadioOptions(question['options'], key),
          ],
        );
      case 'dropdown':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            questionText,
            SizedBox(height: 24),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              hint: Text("Seçiniz"),
              underline: Container(height: 1, color: Color(0xFF6C63FF)),
              dropdownColor: Colors.white,
              style: TextStyle(color: Colors.black87, fontSize: 18),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue;
                  answers[key] = newValue!;
                });
              },
              items: question['options']
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      default:
        return Text("Bilinmeyen soru tipi.");
    }
  }

  bool canGoNext() {
    final question = questions[questionIndex];
    final key = question['key'];
    if (question['type'] == 'input') {
      final text = controller.text.trim();
      return text.isNotEmpty && errorText == null;
    }
    if (question['type'] == 'dropdown') {
      return dropdownValue != null;
    }
    if (question['type'] == 'radio') {
      return answers[key] != null;
    }
    return false;
  }

  void onNextPressed() {
    final question = questions[questionIndex];
    final key = question['key'];
    dynamic value;
    if (question['type'] == 'input') {
      final text = controller.text.trim();
      value = text;
    } else if (question['type'] == 'dropdown') {
      value = dropdownValue;
    } else {
      value = answers[key];
    }
    next(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: questionIndex < questions.length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProgressBar(),
                        if (submitError != null) ...[
                          Text(submitError!, style: TextStyle(color: Colors.red)),
                          SizedBox(height: 12),
                        ],
                        if (isSubmitting)
                          Center(child: CircularProgressIndicator()),
                        if (!isSubmitting) buildQuestion(),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF6C63FF), size: 64),
                        SizedBox(height: 16),
                        Text(
                          "Teşekkürler! Cevaplarınız kaydedildi.",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: questionIndex < questions.length && !isSubmitting
          ? Container(
              color: Colors.transparent,
              padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: canGoNext() ? onNextPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
