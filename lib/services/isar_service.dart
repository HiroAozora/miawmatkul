import 'package:isar/isar.dart';
import '../models/jadwal.dart';
import '../models/jadwal_exception.dart';


class IsarService {
  final Isar isar;

  IsarService(this.isar);

  // 1. CREATE: Tambah jadwal baru ke HP (Lokal)
  Future<void> tambahJadwal(JadwalKuliah jadwal) async {
    await isar.writeTxn(() async {
      await isar.jadwalKuliahs.put(jadwal);
    });
  }

  // 2. READ: Ambil semua jadwal (Buat tampilin semua)
  Future<List<JadwalKuliah>> ambilSemuaJadwal() async {
    return await isar.jadwalKuliahs.where().findAll();
  }

  // 3. READ SPESIFIK: Ambil jadwal berdasarkan Hari (Misal: cuma hari "Selasa" buat kelas IK-2)
  Future<List<JadwalKuliah>> ambilJadwalHari(String hari) async {
    return await isar.jadwalKuliahs.filter().hariEqualTo(hari).findAll();
  }

  // 4. DELETE: Hapus jadwal kalau dosennya ganti jadwal atau KRS batal
  Future<void> hapusJadwal(int id) async {
    await isar.writeTxn(() async {
      await isar.jadwalKuliahs.delete(id);
    });
  }

  // 5. CLEAR: Hapus semua jadwal (Berguna pas ganti semester)
  Future<void> bersihkanJadwal() async {
    await isar.writeTxn(() async {
      await isar.jadwalKuliahs.clear();
    });
  }
  // =======================================================
  // FITUR BARU: PENGECUALIAN JADWAL (ONLINE / LIBUR)
  // =======================================================

  // 1. Simpan Pengecualian (Misal pas user klik pindah online/libur)
  Future<void> simpanPengecualian(JadwalException pengecualian) async {
    await isar.writeTxn(() async {
      await isar.jadwalExceptions.put(pengecualian);
    });
  }

  // 2. Ambil Pengecualian berdasarkan Tanggal dan ID Jadwal
  // (Biar sistem tau: "Eh, matkul Web Dev hari ini libur nggak ya?")
  Future<JadwalException?> cekPengecualian(int jadwalId, DateTime tanggal) async {
    // Kita samakan jamnya jadi jam 00:00:00 biar pencariannya akurat cuma beda hari
    final startOfDay = DateTime(tanggal.year, tanggal.month, tanggal.day);

    return await isar.jadwalExceptions
        .filter()
        .jadwalIdEqualTo(jadwalId)
        .tanggalEqualTo(startOfDay)
        .findFirst();
  }

  // 3. Hapus Pengecualian (Kalau user batalin status liburnya dan balik ke offline)
  Future<void> hapusPengecualian(int id) async {
    await isar.writeTxn(() async {
      await isar.jadwalExceptions.delete(id);
    });
  }
}