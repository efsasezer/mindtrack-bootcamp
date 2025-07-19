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
| Galip Talha Erbaş | Developer |

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

**Ürün Durumu**
Sprint sonunda sistemin temel iskeleti oluşturuldu. Arayüz ile API entegrasyonu tamamlandı ve kullanıcıdan alınan veriler üzerinden depresyon tahmini yapılabiliyor hale geldi.
Teknik Aşamalar:
Model Eğitimi: Eğitim tamamlandı ve model .pkl dosyası olarak kaydedildi
FastAPI Servisi: Tahmin üretimi için yapılandırıldı ve başarıyla test edildi
Frontend: Form ekranı ve tahmin sonucu ekranı geliştirildi
Veri Aktarımı: Kullanıcı verisi API’ye iletildi, tahmin sonucu geri döndü
Firebase Entegrasyonu: Auth ve Firestore ayarlandı, kullanıcı girişi ve veri kaydı sağlandı
Veriye Uygun Soru Seti: Kullanıcıya yöneltilecek sorular analizle eşleştirildi

**Sprint Review**

Bu sprintte yapılan işler:
Modelin eğitilmesi ve kaydedilmesi
FastAPI servisi kurulması
Form tabanlı arayüzün oluşturulması
Kullanıcı verisinin API üzerinden tahmin motoruna aktarılması
Firebase entegrasyonu: authentication + veri kayıt yapısı
Kullanıcıya sorulacak veriye dayalı soruların hazırlanması

**Sprint Katılımcıları**

- Efsa Sezer (Product Owner) - Aktif
- Sultan Kırkan (Scrum Master) - Aktif
- Fatih Mehmet Dikici (Developer) - Aktif
- Sude Naz Öztürk (Developer) - Aktif
- Galip Talha Erbaş (Developer) - Aktif Değil/ Ekipten Ayrıldı

**Sprint Retrospective**

İyi Gidenler:
İyileştirilmesi Gerekenler:
