# bootcamp-sprint-project

## **Takım İsmi**

**Takım 86**

## Takım Elemanları

| <div align="center">Name</div>   | <div align="center">Title</div>  |  
| :---------- | :---------- | 
| Efsa Sezer | Product Owner |
| Sultan Kırkan| Scrum Master |
| Fatih Mehmet Dikici | Developer |
| Sude Naz Öztürk | Developer |
| Galip Talha Erbaş | Developer (Ekipten Ayrıldı) |

##   Ürünün İsmi
**MindTrack - Öğrenci Ruh Sağlığı Tahmin ve Takip Sistemi**

## Ürünün Logosu

![Mindtrack Logo](https://raw.githubusercontent.com/efsasezer/mindtrack-bootcamp/main/mindtrack_logo.png)

## Ürünün Açıklaması

Üniversite öğrencilerini yaşam tarzı alışkanlıklarına (uyku, sosyal medya, sigara vs.) ve psikolojik semptomlarına göre *depresyon seviyesini tahmin eden* ve kullanıcıya özel öneriler sunan bir yapay zeka destekli sistem geliştirmek.

## Hedef Kitle

- Üniversite öğrencileri (18–26 yaş aralığı)
- Psikolojik danışmanlık merkezleri (PDR)
- Üniversiteler (kurumsal lisanslama ile)
- Mental sağlık uygulamaları ve startup'lar

## Pazarlama Stratejisi

### 1. **B2C Pazarlama:**
- Sosyal medya kampanyaları (Instagram, TikTok üzerinden “kendini test et” tanıtımı)
- Mental sağlık farkındalık günlerinde tanıtım (10 Ekim Dünya Ruh Sağlığı Günü gibi)
- Üniversite topluluklarıyla iş birlikleri

### 2. **B2B Pazarlama:**
- Üniversitelerle iş ortaklıkları (danışmanlık merkezleri için dashboard versiyonu)
- Startup yarışmalarına katılım


## Ürünün Bileşenleri

- **Veri Analizi ve Temizlik**
  - Eksik değer doldurma, encoding, normalizasyon
- **Makine Öğrenmesi ile Tahmin**
  - Random Forest, XGBoost ile sınıflandırma
- **Öneri Motoru**
  - Kullanıcının depresyon seviyesi ve risk faktörlerine göre öneri
- **Arayüz (opsiyonel)**
  - Streamlit tabanlı arayüz
  - Kullanıcı veri girişi + tahmin + öneri

## Kullanılan Proje Yönetim Platformu

Trello üzerinden sprint planlaması ve görev takibi yapılmıştır.

Trello proje linki: https://trello.com/invite/b/6863f1d51ce2013457f400b1/ATTI553a5f8e72238d784f01e4f1a26af351BC7B3A91/mindtrack-bootcamp


## Kullanılan Teknolojiler

| Alan              | Teknoloji               |
|-------------------|--------------------------|
| Programlama       | Python                   |
| ML Modelleri      | Scikit-Learn, XGBoost    |
| Veri İşleme       | Pandas, NumPy            |
| Görselleştirme    | Matplotlib, Plotly       |
| Arayüz (Opsiyonel)| Streamlit, FastAPI       |
| Takip & Planlama  | Trello                   |

## Sprint 1 Raporu

**Sprint Notları**

Sprint 1’de proje fikri belirlendi ve takım içinde görev dağılımı yapıldı. Kullanılacak veri seti seçildi, ön analizler ve veri temizleme işlemleri gerçekleştirildi. İlk model denemeleri üzerine tartışmalar yapıldı ve temel planlama tamamlandı. Trello üzerinden görev takibi yapıldı ve iletişim çoğunlukla WhatsApp aracılığıyla sağlandı. Belirli günlerde Google Meet toplantıları düzenlendi. Tüm katılımcılar sürece aktif katılım gösterdi.

**Sprint İçinde Tamamlanması Tahmin Edilen Puan**

Tahmin Edilen Tamamlanacak Puan: 100 puan
Gerçekleşen Puan: 80 puan

**Tahmin Mantığı**

- Proje toplamda 300 puan olarak planlandı. Başlangıçta bu puan üç eşit sprint’e (100-100-100) bölündü.
- Ancak ekip üyemizden birinin ayrılması ve yeni bir ekip arkadaşının sonradan eklenmesi süreci biraz aksatmıştır. Bu nedenle bu sprintte ancak 80 puanlık iş tamamlanmıştır.
- Sonuç olarak kalan 220 puan, Sprint 2 ve Sprint 3’e 110’ar puan olarak dağıtılacaktır.

**Daily Scrum**

- Takım üyeleri olarak WhatsApp üzerinden iletişim sağladık, iki-üç günde bir durumumuzu konuşmak için meets üzerinden toplantı gerçekleştirdik.
- İlk hafta tanışma, roller ve proje fikri üzerine konuşmalar yapılmıştır.
- İkinci hafta proje fikri kararlaştırılmış, görevler high level olarak atanmıştır.
- Genellikle akşam saatlerinde iletişim kurulmuştur.
- İletişim Kanalları: WhatsApp grubu, Google Meets.

**Sprint Board Updates**

- Trello üzerinden sprint planlaması başlatılmıştır.
![Mindtrack Trello](https://raw.githubusercontent.com/efsasezer/mindtrack-bootcamp/refs/heads/main/trello_mindtrack.jpg)

**Ürün Durumu**

- Ürün fikir aşamasında şekillenmiştir.
- İlk veri seti bulunmuş ve projeye dahil edilmiştir.
- İş bölümü high-level (genel düzeyde) yapılmıştır.

**Sprint Review**

Bu sprintte yapılanlar:
- Proje fikrine karar verildi: MindTrack – Öğrenci Ruh Sağlığı Takip Sistemi.
    -  Motivasyon: Ekip üyelerimiz üniversite öğrenciliği sürecinde psikolojik zorlukların, akademik ve sosyal yaşam üzerindeki etkilerine bireysel olarak tanık oldu. Bu nedenle, öğrencilerin ruh sağlığına yönelik erken farkındalık sağlayacak bir sistem geliştirme fikri ortak bir ihtiyaç olarak belirlendi.
- Veri seti bulundu ve projeye eklendi.
- Takım üyeleri arasındaki görev paylaşımı yapıldı (high-level).
- İletişim kanalları netleştirildi.
- Trello kurulumu yapıldı.

**Sprint Katılımcıları**

- Efsa Sezer (Product Owner) - Aktif
- Sultan Kırkan (Scrum Master) - Aktif
- Fatih Mehmet Dikici (Developer) - Aktif
- Sude Naz Öztürk (Developer) - Aktif
- Galip Talha Erbaş (Developer) - Aktif

**Sprint Retrospective**

İyi Gidenler:
- Fikir birliği hızlı sağlandı.
- Veri seti süreci başarıyla tamamlandı.
- İletişim kanalları etkin kullanıldı.
- Herkesin aktif katılımı sağlandı.
- İş bölümü ve rol dağılımı yapıldı.

İyileştirilmesi Gerekenler:
- Ekip değişikliği süreci sprinti yavaşlattı, bir sonraki sprintlerde toplanması gerekiyor.
- Final haftaları nedeniyle ilerleme yavaştı, diğer sprintlerde telafi edilecektir.


## Sprint 2 Raporu

**Sprint Notları**

Sprint 2’de model eğitimi tamamlandı ve eğitilen model kaydedildi. FastAPI kullanılarak model servisi geliştirildi ve test edildi. Frontend arayüz tasarlandı; kullanıcı formu oluşturuldu ve sonuç ekranı geliştirildi. API ile frontend bağlantısı kurularak veri alışverişi sağlandı. Firebase kurulumu yapılarak kullanıcı giriş işlemleri ve veri kaydı tamamlandı. Veriye uygun kullanıcı soruları belirlendi. Takım içi iletişim yine WhatsApp ve Meet üzerinden sürdürüldü, Trello ile görev takibi yapıldı. Sprint sürecinde ekip arkadaşımız Galip projeden ayrılma kararı aldı. Ekip olarak hızlıca organize olup görev dağılımını yeniden yaparak süreci sorunsuz şekilde devam ettirdik ve sprinti dört kişi olarak tamamladık.


**Sprint İçinde Tamamlanması Tahmin Edilen Puan**

Tahmin Edilen Tamamlanacak Puan: 110 puan
Gerçekleşen Puan: 110 puan

**Tahmin Mantığı**

Toplam proje 300 puan üzerinden planlandı. Her sprintte 100 puanlık iş tamamlanması hedeflendi, ilk sprint 80 puan olduğu için diğer iki sprint 110 puan olacak şekilde yeniden planlandı. Bu sprintte model servisi kurulumu, arayüz geliştirme, Firebase entegrasyonu gibi önemli orta-ağır görevler başarıyla yürütüldü.

**Daily Scrum**

- Takım üyeleri olarak WhatsApp üzerinden iletişim sağladık, iki-üç günde bir durumumuzu konuşmak için meets üzerinden toplantı gerçekleştirdik.
- Genellikle akşam saatlerinde iletişim kurulmuştur.
- İletişim Kanalları: WhatsApp grubu, Google Meets.

**Sprint Board Updates**

- Trello üzerinden sprint planlamasına devam edilmiştir.
![Mindtrack Trello](https://raw.githubusercontent.com/efsasezer/mindtrack-bootcamp/refs/heads/main/trello_sprint2.png)


**Ürün Durumu**

Sprint sonunda sistemin temel iskeleti oluşturuldu. Arayüz ile API entegrasyonu tamamlandı ve kullanıcıdan alınan veriler üzerinden depresyon tahmini yapılabiliyor hale geldi.

Teknik Aşamalar:
- Model Eğitimi: Eğitim tamamlandı ve model .pkl dosyası olarak kaydedildi
- FastAPI Servisi: Tahmin üretimi için yapılandırıldı ve başarıyla test edildi
- Frontend: Form ekranı ve tahmin sonucu ekranı geliştirildi
- Veri Aktarımı: Kullanıcı verisi API’ye iletildi, tahmin sonucu geri döndü
- Firebase Entegrasyonu: Auth ve Firestore ayarlandı, kullanıcı girişi ve veri kaydı sağlandı
- Veriye Uygun Soru Seti: Kullanıcıya yöneltilecek sorular analizle eşleştirildi

Ürünün ekran görüntüsü:
![Mindtrack Trello](https://raw.githubusercontent.com/efsasezer/mindtrack-bootcamp/refs/heads/main/mindtrack_screens.jpeg)

**Sprint Review**

Bu sprintte yapılan işler:
- Modelin eğitilmesi ve kaydedilmesi
- FastAPI servisi kurulması
- Form tabanlı arayüzün oluşturulması
- Kullanıcı verisinin API üzerinden tahmin motoruna aktarılması
- Firebase entegrasyonu: authentication + veri kayıt yapısı
- Kullanıcıya sorulacak veriye dayalı soruların hazırlanması

**Sprint Katılımcıları**

- Efsa Sezer (Product Owner) - Aktif
- Sultan Kırkan (Scrum Master) - Aktif
- Fatih Mehmet Dikici (Developer) - Aktif
- Sude Naz Öztürk (Developer) - Aktif
- Galip Talha Erbaş (Developer) - Aktif Değil/ Ekipten Ayrıldı

**Sprint Retrospective**

- Teknik görevler zamanında tamamlandı
- Takım içi iletişim verimliydi
- Model ve arayüz arasında başarılı bağlantı kuruldu
- Galip’in ekipten ayrılması sonrası görev dağılımı hızlıca yeniden yapıldı, süreç aksatılmadan 4 kişiyle devam edildi.

## Sprint 3 Raporu

**Sprint Notları**

Bu sprintte ürünün tüm parçaları tamamlandı ve bir araya getirildi. Önceki sprintlerde ayrı ayrı geliştirilen modüller bu sprintte entegre edildi. Kullanıcı arayüzü, model servisi ve veri bağlantısı birlikte çalışır hale getirildi. Gemini kullanılarak oluşturulan sohbet botu uygulamaya eklendi ve projeye destekleyici bir özellik olarak entegre edildi. Ayrıca ürünün kısa tanıtım videosu hazırlanarak teslim formu ile birlikte iletildi. Bu sprint ile birlikte proje tamamlanmış oldu.

**Sprint İçinde Tamamlanması Tahmin Edilen Puan**

Tahmin Edilen Tamamlanacak Puan: 110 puan
Gerçekleşen Puan: 110 puan

**Tahmin Mantığı**

Proje başta toplam 300 puan üzerinden planlandı. İlk sprintte 80 puan, ikinci ve üçüncü sprintlerde ise 110’ar puan tamamlanacak şekilde yapılandırıldı. Bu sprintte hedeflenen 110 puan başarıyla tamamlandı ve böylece toplam 300 puanlık proje tam olarak tamamlanmış oldu.

**Daily Scrum**

- İletişim genellikle WhatsApp grubu üzerinden sağlandı.
- İhtiyaç duyulan zamanlarda Google Meet üzerinden çevrim içi toplantılar yapıldı.
- Entegrasyon ve teslim sürecinde iletişim sıklığı artırıldı.
- İletişim Kanalları: WhatsApp grubu, Google Meet

**Sprint Board Updates**

- Trello üzerinden sprint planlamasına devam edilmiştir.
![Mindtrack Trello]()

**Ürün Durumu**

Sprint 3 sonunda ürün kullanıma hazır hale geldi. Tüm modüller birleştirildi, sistem testleri yapıldı. Gemini kullanılarak oluşturulan sohbet botu özelliği sisteme entegre edildi. Tanıtım videosu tamamlandı ve ürün teslim formu ile birlikte sunuldu.

Tamamlanan Teknik Aşamalar:

- Backend ve frontend modüllerinin entegrasyonu
- Uygulama testlerinin yapılması
- Gemini ile sohbet botunun oluşturulması ve entegre edilmesi
- Tanıtım videosunun hazırlanması
- Ürün teslim formunun gönderilmesi

![Mindtrack Trello]()

**Sprint Review**
Bu sprintte tamamlanan işler:

- Eksik kalan modüllerin tamamlanması
- Tüm sistem bileşenlerinin birleştirilmesi
- Gemini ile sohbet botu içeriğinin oluşturulması ve uygulamaya eklenmesi
- Tanıtım videosunun hazırlanması
- Ürün teslim formunun iletilmesi


**Sprint Katılımcıları**

- Efsa Sezer (Product Owner) - Aktif
- Sultan Kırkan (Scrum Master) - Aktif
- Fatih Mehmet Dikici (Developer) - Aktif
- Sude Naz Öztürk (Developer) - Aktif
- Galip Talha Erbaş (Developer) - Aktif Değil/ Ekipten Ayrıldı

**Sprint Retrospective**

İyi Gidenler:

- Ürün başarıyla tamamlandı ve tüm modüller entegre edildi
- Sohbet botu uygulamaya değerli bir ek olarak kazandırıldı
- Tanıtım ve teslim süreci sorunsuz şekilde yönetildi
- Ekip içi iş birliği ve iletişim üst düzeydeydi

Geliştirilebilecek Noktalar:

- Entegrasyon süreci yoğun geçti, ancak ekip uyum içinde ilerledi ve tüm hedefler zamanında tamamlandı.

