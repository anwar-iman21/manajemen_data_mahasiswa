# Aplikasi Manajemen Data Mahasiswa

Aplikasi mobile sederhana untuk mengelola data mahasiswa menggunakan **Flutter**. Aplikasi ini dibuat untuk memenuhi tugas mata kuliah **Pemrograman Aplikasi Mobile** dengan fokus pada pengelolaan state lokal dan operasi CRUD sederhana.

> Data hanya disimpan sementara menggunakan `List` dan `setState()`. Data akan kembali ke data awal ketika aplikasi ditutup atau di-*restart*.

## Fitur Utama

- Menampilkan minimal 5 data mahasiswa awal.
- Menampilkan total jumlah mahasiswa.
- Menambahkan data mahasiswa baru.
- Validasi form agar NIM, nama, program studi, dan kelas tidak kosong.
- Melihat detail data mahasiswa.
- Mengedit data mahasiswa dengan form yang otomatis terisi data sebelumnya.
- Menghapus data mahasiswa dengan dialog konfirmasi.
- Mencari mahasiswa berdasarkan **nama** atau **NIM**.
- Memfilter mahasiswa berdasarkan program studi.
- Menampilkan pesan *empty state* ketika seluruh data mahasiswa sudah dihapus.

## Teknologi yang Digunakan

| Teknologi | Keterangan |
| --- | --- |
| Flutter | Framework untuk membangun aplikasi mobile. |
| Dart | Bahasa pemrograman utama pada Flutter. |
| Material Design | Komponen antarmuka bawaan Flutter. |
| `List<Mahasiswa>` | Media penyimpanan data sementara di memori. |
| `setState()` | Memperbarui tampilan setelah data berubah. |

Aplikasi ini tidak menggunakan Firebase, REST API, MySQL, SQLite, Provider, Riverpod, GetX, atau package tambahan.

## Konsep Flutter yang Diterapkan

- `StatefulWidget`
- `setState()`
- `TextEditingController`
- `Form`
- `TextFormField`
- Validasi input
- `List`
- `ListView.builder`
- `Card`
- `Navigator`
- `AlertDialog`
- CRUD lokal (*Create, Read, Update, Delete*)

## Struktur Project

```text
manajemen_data_mahasiswa/
├── lib/
│   └── main.dart              # Source code utama aplikasi
├── test/
│   └── widget_test.dart       # Pengujian widget sederhana
├── pubspec.yaml               # Konfigurasi dependency Flutter
└── README.md                  # Dokumentasi project
```

## Struktur Data Mahasiswa

Setiap mahasiswa memiliki empat data utama:

- **NIM**
- **Nama**
- **Program Studi**
- **Kelas**

Data direpresentasikan dengan model berikut:

```dart
class Mahasiswa {
  const Mahasiswa({
    required this.nim,
    required this.nama,
    required this.programStudi,
    required this.kelas,
  });

  final String nim;
  final String nama;
  final String programStudi;
  final String kelas;
}
```

## Persyaratan Instalasi

Sebelum menjalankan project, pastikan perangkat sudah memiliki:

1. [Flutter SDK](https://docs.flutter.dev/get-started/install)
2. Dart SDK (sudah termasuk bersama Flutter)
3. Android Studio atau Visual Studio Code
4. Emulator Android, perangkat Android fisik, atau browser/desktop target Flutter

Pastikan instalasi Flutter sudah benar dengan perintah berikut:

```bash
flutter doctor
```

Perbaiki terlebih dahulu jika `flutter doctor` masih menampilkan masalah penting, terutama pada Android SDK atau perangkat target.

## Cara Instalasi dan Menjalankan Project

### 1. Clone repository

```bash
git clone https://github.com/anwar-iman21/manajemen_data_mahasiswa.git
```

### 2. Masuk ke folder project

```bash
cd manajemen_data_mahasiswa
```

### 3. Ambil dependency Flutter

```bash
flutter pub get
```

### 4. Cek perangkat yang tersedia

```bash
flutter devices
```

### 5. Jalankan aplikasi

```bash
flutter run
```

Jika menggunakan Visual Studio Code, project juga dapat dijalankan dengan menekan tombol **Run and Debug** atau tombol **F5** setelah memilih perangkat/emulator.

## Panduan Penggunaan Fitur

### 1. Melihat Daftar Mahasiswa

Saat aplikasi dibuka, halaman **Data Mahasiswa** akan menampilkan lima data mahasiswa awal dalam bentuk card. Di bagian atas halaman terdapat informasi total mahasiswa.

### 2. Menambah Mahasiswa

1. Tekan tombol **Tambah Mahasiswa** di bagian bawah halaman.
2. Isi NIM, Nama, Program Studi, dan Kelas.
3. Tekan tombol **Simpan**.
4. Data baru akan tampil pada daftar mahasiswa.

### 3. Validasi Form

Semua kolom pada form wajib diisi. Jika tombol simpan ditekan ketika ada kolom kosong, aplikasi menampilkan pesan seperti:

```text
NIM wajib diisi
Nama wajib diisi
Program Studi wajib diisi
Kelas wajib diisi
```

### 4. Melihat Detail Mahasiswa

1. Tekan salah satu card mahasiswa pada halaman daftar.
2. Aplikasi akan membuka halaman **Detail Mahasiswa**.
3. Halaman tersebut menampilkan NIM, Nama, Program Studi, dan Kelas mahasiswa yang dipilih.

### 5. Mengedit Mahasiswa

1. Buka halaman detail salah satu mahasiswa.
2. Tekan ikon **Edit** di bagian kanan atas.
3. Ubah data yang diperlukan.
4. Tekan tombol **Simpan Perubahan**.
5. Data pada daftar akan diperbarui.

### 6. Menghapus Mahasiswa

1. Buka halaman detail mahasiswa.
2. Tekan ikon **Hapus** di bagian kanan atas.
3. Akan muncul dialog konfirmasi.
4. Tekan **Batal** untuk membatalkan, atau tekan **Hapus** untuk menghapus data.
5. Setelah dikonfirmasi, data akan hilang dari daftar dan total mahasiswa berkurang.

### 7. Mencari Mahasiswa

Gunakan kolom pencarian di halaman utama.

- Ketik nama, misalnya `Andi`, untuk mencari berdasarkan nama.
- Ketik NIM, misalnya `231001`, untuk mencari berdasarkan NIM.

Daftar mahasiswa akan berubah otomatis sesuai kata kunci yang dimasukkan.

### 8. Memfilter Program Studi

Gunakan pilihan **Filter Program Studi** untuk menampilkan mahasiswa berdasarkan program studi berikut:

- Semua
- Informatika
- Sistem Informasi
- Teknik Komputer

### 9. Empty State

Jika semua data mahasiswa dihapus, aplikasi menampilkan pesan:

```text
Belum ada data mahasiswa
```

## Cara Menjalankan Pengujian

Project memiliki pengujian widget sederhana untuk memastikan halaman utama dan fitur pencarian dapat ditampilkan.

Jalankan perintah berikut:

```bash
flutter test
```

Untuk mengecek analisis kode Dart, jalankan:

```bash
flutter analyze
```

## Screenshot Aplikasi

Tambahkan screenshot aplikasi pada bagian ini apabila diperlukan.

| Fitur | Screenshot |
| --- | --- |
| Halaman daftar mahasiswa | `[Tambahkan screenshot di sini]` |
| Form tambah mahasiswa | `[Tambahkan screenshot di sini]` |
| Validasi form | `[Tambahkan screenshot di sini]` |
| Detail mahasiswa | `[Tambahkan screenshot di sini]` |
| Form edit mahasiswa | `[Tambahkan screenshot di sini]` |
| Dialog hapus mahasiswa | `[Tambahkan screenshot di sini]` |
| Pencarian mahasiswa | `[Tambahkan screenshot di sini]` |

## Catatan

- Data aplikasi tidak disimpan ke database.
- Data akan hilang atau kembali ke data awal ketika aplikasi di-*restart*.
- Project ini dibuat untuk pembelajaran CRUD lokal dasar menggunakan Flutter.

## Author

**Anwar Iman**  
GitHub: [@anwar-iman21](https://github.com/anwar-iman21)
