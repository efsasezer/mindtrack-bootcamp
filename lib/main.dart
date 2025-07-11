import 'package:flutter/material.dart';

void main() => runApp(StudentSurveyApp());

class StudentSurveyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Değerlendirme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F9FD),
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: SurveyPage(),
    );
  }
}

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int questionIndex = 0;
  final answers = <String, dynamic>{};
  final controller = TextEditingController();
  String? dropdownValue;
  String? errorText; // Hata mesajı için

  final Map<String, String> ranges = {
    'Akademik Baskı': '(1-5)',
    'Not Ortalaması': '(1-10)',
    'Memnuniyet': '(1-5)',
    'Finansal Stres': '(1-5)',
  };

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
      'text': 'Akademik baskı düzeyiniz:',
      'type': 'input',
      'key': 'Akademik Baskı',
    },
    {'text': 'Not ortalamanız:', 'type': 'input', 'key': 'Not Ortalaması'},
    {
      'text': 'Eğitimden memnuniyet düzeyiniz:',
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

  void next(dynamic value) {
    final key = questions[questionIndex]['key'];
    answers[key] = value;
    controller.clear();
    dropdownValue = null;
    errorText = null;
    setState(() => questionIndex++);
  }

  bool isInRange(String key, String value) {
    if (!ranges.containsKey(key)) return true; // Aralık yoksa geçerli say
    final rangeStr = ranges[key]!; // "(1-5)" gibi

    final regex = RegExp(r'\((\d+)-(\d+)\)');
    final match = regex.firstMatch(rangeStr);
    if (match == null) return true;

    final min = int.parse(match.group(1)!);
    final max = int.parse(match.group(2)!);

    final numValue = int.tryParse(value);
    if (numValue == null) return false;

    return numValue >= min && numValue <= max;
  }

  Widget buildProgressBar() {
    double progress = (questionIndex + 1) / questions.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Soru ${questionIndex + 1} / ${questions.length}",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          minHeight: 6,
          color: Color(0xFF5A6BFF),
          backgroundColor: Color(0xFFE0E2F2),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildNextButton(VoidCallback onPressed, {bool enabled = true}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? Color(0xFF5A6BFF) : Colors.grey,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        "Next",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget buildQuestion() {
    final question = questions[questionIndex];
    final key = question['key'];
    final suffix = ranges.containsKey(key) ? " ${ranges[key]}" : "";
    final questionText = Text(
      question['text'] + suffix,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );

    switch (question['type']) {
      case 'input':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProgressBar(),
            questionText,
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Cevabınızı girin",
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  setState(() {
                    if (!isInRange(key, text.trim())) {
                      errorText =
                          "Lütfen $ranges[key] aralığında bir değer girin.";
                    } else {
                      errorText = null;
                    }
                  });
                },
              ),
            ),
          ],
        );
      case 'radio':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProgressBar(),
            questionText,
            SizedBox(height: 20),
            ...question['options'].map<Widget>((option) {
              final isSelected = answers[key] == option;
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isSelected ? Color(0xFF5A6BFF) : Colors.grey[300]!,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  value: option,
                  groupValue: answers[key],
                  onChanged: (val) => setState(() => answers[key] = val),
                  title: Text(option, style: TextStyle(fontSize: 16)),
                  activeColor: Color(0xFF5A6BFF),
                ),
              );
            }),
          ],
        );
      case 'dropdown':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProgressBar(),
            questionText,
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                hint: Text("Seçiniz"),
                underline: SizedBox(),
                dropdownColor: Colors.white,
                style: TextStyle(color: Colors.black87, fontSize: 16),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    errorText = null;
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
            ),
          ],
        );
      default:
        return Text("Bilinmeyen soru tipi.");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool canGoNext() {
      final question = questions[questionIndex];
      final key = question['key'];

      if (question['type'] == 'input') {
        final text = controller.text.trim();
        if (text.isEmpty) return false;
        if (!isInRange(key, text)) return false;
        if (errorText != null) return false;
        return true;
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
        if (!isInRange(key, text)) {
          setState(() {
            errorText = "Lütfen ${ranges[key]} aralığında bir değer girin.";
          });
          return;
        }
        value = text;
      } else if (question['type'] == 'dropdown') {
        value = dropdownValue;
      } else {
        value = answers[key];
      }

      next(value);
    }

    return Scaffold(
      appBar: AppBar(title: Text("Değerlendirme")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: questionIndex < questions.length
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildQuestion(),
                    if (errorText != null) ...[
                      SizedBox(height: 8),
                      Text(
                        errorText!,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 80,
                    ), // Butonun alt boşluğunu açar, scroll için
                  ],
                ),
              )
            : ListView(
                children: [
                  Text(
                    "Teşekkürler! Cevaplarınız:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ...answers.entries.map((entry) {
                    String key = entry.key;
                    String value = entry.value.toString();
                    if (ranges.containsKey(key)) value += ' ${ranges[key]}';

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$key: $value",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }),
                ],
              ),
      ),
      bottomNavigationBar: questionIndex < questions.length
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: buildNextButton(onNextPressed, enabled: canGoNext()),
              ),
            )
          : null,
    );
  }
}
