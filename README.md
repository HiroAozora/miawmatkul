<div align="center">
  <img src="assets/icon/icon.png" width="120" alt="MiawMatkul Logo">
  <h1>MiawMatkul 🐱</h1>
  <p><b>Asisten Manajemen Jadwal Kuliah Khusus Mahasiswa</b></p>
  
  [![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?logo=dart&logoColor=white)](https://dart.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
</div>

---

## 🌟 Tentang Aplikasi

**MiawMatkul** adalah aplikasi mobile berbasis Flutter yang dirancang khusus untuk membantu mahasiswa mengorganisir jadwal kuliah, ruangan, dan kelas dengan cepat dan sangat efisien.

Dibangun dengan antarmuka _glassmorphism_ yang modern, ringan, dan didukung database lokal ultra-cepat ([Isar](https://isar.dev/)), aplikasi ini memecahkan masalah klasik mahasiswa: **Lupa jadwal, salah ruang, dan malas ngetik.**

---

## ✨ Fitur Utama

- 📅 **Jadwal Terorganisir:** Tampilan jadwal harian/mingguan yang intuitif.
- 📍 **Informasi Ruangan Akurat:** Pantau lokasi gedung dan ruangan perkuliahan agar kamu tidak pernah nyasar atau salah kelas lagi.
- 🔔 **Pengingat Pintar (FCM):** Terintegrasi Firebase Cloud Messaging untuk notifikasi admin/info mendadak secara _real-time_.
- ☁️ **Sistem In-App Update (OTA):** Notifikasi pop-up cerdas jika ada versi aplikasi terbaru, menuntun pengguna langsung ke file APK versi terbaru tanpa lewat PlayStore.
- ⚡ **Offline-First:** Semua data jadwal disimpan di lokal (Isar Database). Nggak ada internet? Nggak masalah!

---

## 🛠️ Tech Stack & Dependencies

- **Framework:** Flutter (Dart)
- **Local Database:** `isar`, `isar_flutter_libs`
- **State Management / Dependency Injection:** `provider`, `get_it`
- **Backend / Push Notifications:** Firebase Core, Firebase Messaging, Cloud Firestore
- **Networking & Utilities:** `url_launcher`, `package_info_plus`, `google_generative_ai` (untuk ekstraksi teks jadwal)

---

## 🚀 Panduan Setup & Instalasi (Untuk Developer)

Karena aplikasi ini terhubung ke layanan eksternal (Firebase & Gemini AI), ada beberapa file rahasia yang **tidak** diunggah ke GitHub demi keamanan. Ikuti langkah ini untuk menjalankan project di komputermu:

### 1. Clone Repository

```bash
git clone https://github.com/HiroAozora/miawmatkul.git
cd miawmatkul
flutter pub get
```

### 2. Konfigurasi Firebase (google-services.json)

Aplikasi ini butuh Firebase untuk Notifikasi & Cek Update OTA.

1. Buat project baru di [Firebase Console](https://console.firebase.google.com/).
2. Daftarkan aplikasi Android dengan package name: `com.hiroaozora.miawmatkul`.
3. Download file `google-services.json`.
4. Masukkan file tersebut ke dalam folder: `android/app/google-services.json`.

_(Struktur Firestore untuk sistem OTA bisa dilihat di bagian bawah)._

### 3. Build dan Run

```bash
# Menjalankan build runner untuk Isar
flutter pub run build_runner build --delete-conflicting-outputs

# Jalankan aplikasi di device/emulator
flutter run
```

---

## ☁️ Referensi Database (Sistem Update OTA)

Jika kamu ingin menguji coba dialog pop-up **Cek Pembaruan / OTA**, kamu wajib membuat _Collection_ di Cloud Firestore milikmu dengan struktur persis seperti ini:

- **Collection:** `config`
- **Document ID:** `app_version`
- **Fields:**
  - `latestVersionCode` _(Number/String)_ : `2` (Angka yang lebih besar dari pubspec.yaml kamu)
  - `latestVersionName` _(String)_ : `1.1.0`
  - `downloadUrl` _(String)_ : Link Google Drive atau Github Release dari APK terbarumu
  - `releaseNotes` _(String)_ : `"Perbaikan bug minor dan penambahan animasi."`
  - `forceUpdate` _(Boolean)_ : `false`

---

## 🤝 Berkontribusi

Pull requests (PR) sangat diperbolehkan! Untuk perubahan besar, tolong buka **Issue** terlebih dahulu untuk mendiskusikan apa yang ingin kamu ubah.

Dibuat dengan sakit pinggang oleh [@HiroAozora](https://github.com/HiroAozora). 🚀
