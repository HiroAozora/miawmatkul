import 'package:isar/isar.dart';

// Baris ini SUPER PENTING. Jangan sampai salah ketik.
// Ini ngasih tahu Flutter: "Tolong buatin file .g.dart nanti ya"
part 'jadwal.g.dart';

@collection
class JadwalKuliah {
  Id id = Isar.autoIncrement; // ID unik otomatis untuk database lokal (Isar)

  // ID unik dari Firebase (berguna pas sinkronisasi data dari admin nanti)
  @Index(unique: true, replace: true)
  String? firestoreId;

  String? hari;         // misal: "Selasa"
  String? namaMatkul;   // misal: "Pemrograman Mobile"
  String? dosen;
  String? ruangan;      // misal: "Gedung H / Lab"
  String? jamMulai;     // misal: "13:00"
  String? jamSelesai;   // misal: "15:30"

  // Status langganan notif khusus matkul ini (untuk fitur Dosen Libur)
  bool isSubscribed = true;
}