import 'package:flutter_test/flutter_test.dart';
import 'package:bootcamp/main.dart'; // Eğer dosya adı farklıysa düzelt

void main() {
  testWidgets('İlk soru görünüyor ve İleri butonu çalışıyor', (
    WidgetTester tester,
  ) async {
    // Uygulamayı başlat
    await tester.pumpWidget(StudentSurveyApp());

    // İlk sorunun doğru şekilde görünüp görünmediğini kontrol et
    expect(find.textContaining("Cinsiyetiniz"), findsOneWidget);

    // "Kadın" seçeneğini bul ve seç
    final genderOption = find.text("Kadın");
    expect(genderOption, findsOneWidget);
    await tester.tap(genderOption);
    await tester.pump();

    // "İleri" butonunu bul ve tıkla
    final nextButton = find.text("İleri");
    expect(nextButton, findsOneWidget);
    await tester.tap(nextButton);
    await tester.pump();

    // İkinci sorunun (Yaş) ekranda olduğunu doğrula
    expect(find.textContaining("Yaş"), findsOneWidget);
  });
}
