import 'package:isar/isar.dart';

part 'jadwal_exception.g.dart';

@collection
class JadwalException {
  Id id = Isar.autoIncrement;

  @Index()
  int? jadwalId; // Menyimpan ID dari jadwal matkul aslinya

  @Index()
  DateTime? tanggal; // Tanggal spesifik kelas tersebut diganti/diliburkan

  String? status; // Isinya nanti: "online" atau "libur"

  String? keterangan; // Untuk menyimpan Link Zoom/Gmeet atau Alasan Libur
}