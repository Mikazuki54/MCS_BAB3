# MCS BAB 3 - Aplikasi Katalog Ras Kucing & Firebase Authentication

Aplikasi mobile berbasis **Flutter** yang mengimplementasikan **Firebase Authentication**, **State Management dengan Provider**, navigasi data master-detail daftar ras kucing, animasi **Lottie**, serta dukungan **Device Preview** untuk pengujian multi-resolusi perangkat.

---

## 📌 Daftar Isi
- [Tentang Proyek](#-tentang-proyek)
- [Fitur Utama](#-fitur-utama)
- [Teknologi & Dependensi](#-teknologi--dependensi)
- [Struktur Direktori](#-struktur-direktori)
- [Penjelasan Arsitektur & Komponen](#-penjelasan-arsitektur--komponen)
  - [1. Authentication & Gatekeeper](#1-authentication--gatekeeper)
  - [2. State Management (AppProvider)](#2-state-management-appprovider)
  - [3. Katalog Data Ras Kucing](#3-katalog-data-ras-kucing)
  - [4. Device Preview](#4-device-preview)
- [Panduan Instalasi & Menjalankan](#-panduan-instalasi--menjalankan)
- [Tangkapan Layar & Alur Aplikasi](#-tangkapan-layar--alur-aplikasi)

---

## 📖 Tentang Proyek

Proyek ini dikembangkan sebagai bagian dari modul praktikum **Mobile Client Server (MCS)**. Aplikasi ini mendemonstrasikan integrasi antara antarmuka pengguna Flutter yang modern, autentikasi cloud menggunakan Google Firebase, serta manajemen state reaktif menggunakan pustaka Provider.

---

## ✨ Fitur Utama

- **Otentikasi Pengguna (Firebase Auth)**:
  - Form Login dengan validasi email menggunakan pola Regular Expression (Regex).
  - Validasi password tidak boleh kosong.
  - Fitur toggle sembunyikan/tampilkan password (*obscure text toggle*).
  - Dialog notifikasi kegagalan login interaktif dengan animasi **Lottie**.
  - Fungsi Logout akun yang terintegrasi dengan Firebase `signOut`.
- **Katalog Ras Kucing (Master-Detail Flow)**:
  - Tampilan daftar ras kucing (Persia, Ragdoll, Siam, Sphynx, Maine Coon, Munchkin, Bengal, British Shorthair).
  - Pemuatan gambar jaringan (*network image*) dengan efek sudut melengkung (*rounded corners*).
  - Halaman detail yang menyajikan foto penuh dan deskripsi karakteristik ras kucing secara rapi (*justify alignment*).
- **Pengujian Responsif (Device Preview)**:
  - Terintegrasi dengan pustaka `device_preview` untuk mensimulasikan tampilan aplikasi di berbagai ukuran layar smartphone, tablet, dan desktop langsung dari web browser/desktop runtime.
- **Tipografi Modern**:
  - Menggunakan font Google Fonts (`Roboto Flex` dan `Oswald`) untuk estetika antarmuka yang bersih dan konsisten.

---

## 🛠 Teknologi & Dependensi

Proyek ini dibangun menggunakan **Flutter SDK ^3.13.5** dengan dependensi utama:

| Paket | Versi | Kegunaan |
|---|---|---|
| [`firebase_core`](https://pub.dev/packages/firebase_core) | `^3.14.0` | Inisialisasi Firebase platform |
| [`firebase_auth`](https://pub.dev/packages/firebase_auth) | `^5.6.0` | Autentikasi pengguna berbasis email & password |
| [`provider`](https://pub.dev/packages/provider) | `^6.1.5` | State management reaktif menggunakan `ChangeNotifier` |
| [`device_preview`](https://pub.dev/packages/device_preview) | `^1.3.1` | Simulator pratinjau multi-perangkat |
| [`google_fonts`](https://pub.dev/packages/google_fonts) | `^9.0.0` | Kustomisasi tipografi (Roboto Flex, Oswald) |
| [`lottie`](https://pub.dev/packages/lottie) | `^3.3.1` | Menampilkan animasi JSON interaktif saat proses gagal |
| [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) | `^1.0.8` | Ikon gaya iOS & antarmuka universal |

---

## 📂 Struktur Direktori

```text
bab3/
├── assets/
│   └── lottie_failed_animations.json   # Animasi Lottie untuk feedback login gagal
├── lib/
│   ├── data/
│   │   └── cat_data.dart               # Dataset statis daftar dan deskripsi ras kucing
│   ├── model/
│   │   └── cat_model.dart              # Model data CatModel (linkGambar, namaKucing, deskripsi)
│   ├── provider/
│   │   └── app_provider.dart           # State logic: validasi form, Firebase Auth, TextEditingController
│   ├── screens/
│   │   ├── auth_gate_page.dart         # Gerbang pengecekan status login (StreamBuilder authStateChanges)
│   │   ├── login_page.dart             # Antarmuka halaman masuk (Login) dengan Card dan Form
│   │   ├── home_page.dart              # Beranda daftar ras kucing (ListView.builder) & tombol logout
│   │   └── detail_page.dart            # Halaman detail gambar & deskripsi lengkap tiap ras kucing
│   ├── services/
│   │   └── firebase_options.dart       # Konfigurasi platform Firebase
│   └── main.dart                       # Entry point aplikasi & konfigurasi DevicePreview / MultiProvider
├── pubspec.yaml                        # Konfigurasi dependensi dan aset proyek
└── README.md                           # Dokumentasi proyek
```

---

## 🔍 Penjelasan Arsitektur & Komponen

### 1. Authentication & Gatekeeper
- **`AuthGatePage`**: Memanfaatkan `StreamBuilder` yang memantau aliran `authStateChanges()` dari `FirebaseAuth`.
  - Jika pengguna terotentikasi: Mengarahkan secara instan ke `HomePage`.
  - Jika pengguna belum terotentikasi / melakukan logout: Otomatis mengarahkan ke `LoginPage`.
- **`LoginPage`**: Dilengkapi elemen visual modern:
  - Form validation dengan kriteria email regex: `^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$`.
  - Tombol toggle password interaktif.
  - Menampilkan `AlertDialog` beranimasi Lottie ketika login tidak berhasil.

### 2. State Management (`AppProvider`)
Menggunakan pola `ChangeNotifier` untuk memisahkan logika bisnis dari UI:
- Mengelola `TextEditingController` untuk email (`usernameController`) dan password (`passController`).
- Menangani metode `loginToApp()`, `logoutAccount()`, dan `resetForm()`.
- Menyimpan properti tema dan konstanta gaya teks (`GoogleFonts`).

### 3. Katalog Data Ras Kucing
- **`CatModel`**: Struktur data berisi atribut `namaKucing`, `linkGambar`, dan `deskripsi`.
- **`cat_data.dart`**: Menyediakan 8 ras kucing terpopuler beserta foto resolusi tinggi dan deskripsi karakter masing-masing.
- **`DetailPage`**: Menerima objek `CatModel` melalui parameter konstruktor dan menampilkannya dengan layout yang terstruktur.

### 4. Device Preview
Diaktifkan pada `main.dart` melalui:
```dart
runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ),
);
```
Memungkinkan pengembang melihat rendering UI pada berbagai rasio layar (iPhone 14, Pixel 7, iPad Pro, dll.) tanpa harus memiliki perangkat fisik.

---

## 🚀 Panduan Instalasi & Menjalankan

### Prasyarat
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi 3.13 ke atas)
- [Git](https://git-scm.com/)
- Peramban Google Chrome atau Emulator Android/iOS

### Langkah-langkah

1. **Clone Repositori**:
   ```bash
   git clone https://github.com/Mikazuki54/MCS_BAB3.git
   cd MCS_BAB3
   ```

2. **Unduh Dependensi**:
   ```bash
   flutter pub get
   ```

3. **Pastikan Konfigurasi Firebase Tersedia**:
   Pastikan file `lib/services/firebase_options.dart` telah terkonfigurasi dengan project Firebase aktif Anda.

4. **Jalankan Aplikasi**:
   - Menjalankan di Chrome (dengan Device Preview):
     ```bash
     flutter run -d chrome
     ```
   - Menjalankan di Emulator Android / Device Fisik:
     ```bash
     flutter run
     ```

---

## 📋 Catatan Penting
- Aset Lottie telah didaftarkan pada `pubspec.yaml` di bawah bagian `flutter -> assets: - assets/`.
- Untuk beralih antara alur login langsung atau melalui gerbang otentikasi, periksa properti `home` pada `MaterialApp` di `lib/main.dart` (`LoginPage`, `HomePage`, atau `AuthGatePage`).
