import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isar/isar.dart';
import '../../models/jadwal.dart';
import '../../models/jadwal_exception.dart';
import '../../main.dart';
import '../widgets/status_kelas_sheet.dart';
import '../../services/notification_service.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late Future<List<JadwalKuliah>> _jadwalHariIni;
  String _hariIni = '';
  String _namaPanggilan = 'Hiro';

  @override
  void initState() {
    super.initState();
    _hariIni = _dapatkanHariIni();
    _muatNamaPanggilan();
    _refreshJadwal();
    _bersihkanJadwalKedaluwarsa();
  }

  void _refreshJadwal() {
    setState(() {
      _jadwalHariIni = isarService.ambilJadwalHari(_hariIni);
    });
  }

  // =======================================================
  // FITUR PINTAR: TUKANG SAPU OTOMATIS
  // Membersihkan status Online/Libur yang sudah lewat (hari kemarin dsb),
  // lalu menghidupkan kembali alarm rutin untuk minggu depannya.
  // =======================================================
  Future<void> _bersihkanJadwalKedaluwarsa() async {
    final now = DateTime.now();
    // Kita set waktu ke jam 00:00 hari ini untuk pembatas
    final hariIni = DateTime(now.year, now.month, now.day);

    // Minta Isar mencari semua pengecualian yang tanggalnya "sebelum" hari ini
    final pengecualianLama = await isarService.isar.jadwalExceptions
        .filter()
        .tanggalLessThan(hariIni)
        .findAll();

    if (pengecualianLama.isEmpty) return; // Kalau nggak ada yang kedaluwarsa, abaikan

    for (var exc in pengecualianLama) {
      // Ambil data matkul aslinya dari database
      final jadwalAsli = await isarService.isar.jadwalKuliahs.get(exc.jadwalId ?? 0);

      if (jadwalAsli != null) {
        // 1. BANGKITKAN KEMBALI ALARM RUTIN MINGGUAN!
        await notificationService.jadwalkanPengingat(
          id: jadwalAsli.id,
          namaMatkul: jadwalAsli.namaMatkul ?? 'Matkul',
          ruangan: jadwalAsli.ruangan ?? 'Ruangan',
          hari: jadwalAsli.hari ?? 'Senin',
          jamMulai: jadwalAsli.jamMulai ?? '00:00',
        );
      }

      // 2. Hapus memori pengecualiannya dari database
      await isarService.hapusPengecualian(exc.id);
    }

    // Refresh layar beranda setelah bersih-bersih
    if (mounted) _refreshJadwal();
  }

  Future<void> _muatNamaPanggilan() async {
    final prefs = await SharedPreferences.getInstance();
    final namaDisimpan = prefs.getString('profil_nama');

    if (namaDisimpan == null || namaDisimpan.isEmpty) {
      // ARTINYA: INI USER BARU INSTALL!
      // Kita set default sementara biar layarnya nggak error
      setState(() {
        _namaPanggilan = 'Mahasiswa';
      });

      // Munculkan Pop-up Kenalan (Dikasih delay dikit biar animasinya smooth pas Beranda baru kebuka)
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _tampilkanDialogKenalan(prefs);
      });
    } else {
      // ARTINYA: USER LAMA, LANGSUNG TAMPILKAN NAMANYA
      setState(() {
        _namaPanggilan = namaDisimpan;
      });
    }
  }

  // Fungsi Pop-up Kenalan (Cuma Muncul 1x)
  void _tampilkanDialogKenalan(SharedPreferences prefs) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
        context: context,
        barrierDismissible: false, // User nggak bisa nutup pop-up dengan ngeklik asal di luar kotak
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: const Text('Halo! 👋\nKenalan yuk?', style: TextStyle(fontWeight: FontWeight.bold)),
            content: TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Nama panggilanmu...',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  final namaBaru = nameController.text.trim();
                  final namaFinal = namaBaru.isNotEmpty ? namaBaru : 'Sobat'; // Kalau dia ngosongin dan maksa save

                  await prefs.setString('profil_nama', namaFinal);

                  setState(() {
                    _namaPanggilan = namaFinal;
                  });

                  if (context.mounted) Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Simpan & Lanjut', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
    );
  }

  String _dapatkanHariIni() {
    int weekday = DateTime.now().weekday;
    switch (weekday) {
      case 1: return 'Senin';
      case 2: return 'Selasa';
      case 3: return 'Rabu';
      case 4: return 'Kamis';
      case 5: return 'Jumat';
      case 6: return 'Sabtu';
      case 7: return 'Minggu';
      default: return 'Senin';
    }
  }

  void _bukaPengaturanStatus(JadwalKuliah jadwal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatusKelasSheet(
        jadwal: jadwal,
        tanggal: DateTime.now(),
        isarService: isarService,
      ),
    ).then((diubah) {
      if (diubah == true) {
        _refreshJadwal();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Halo, $_namaPanggilan! 👋',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            'Ini jadwal kuliahmu untuk hari $_hariIni.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: FutureBuilder<List<JadwalKuliah>>(
              future: _jadwalHariIni,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Waduh, ada error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.weekend_rounded, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'yeayy $_hariIni ini kosong\nbisa la ya ngerjain laprak',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[500], fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                final jadwalList = snapshot.data!;
                return ListView.builder(
                  itemCount: jadwalList.length,
                  itemBuilder: (context, index) {
                    final jadwal = jadwalList[index];
                    return _buildCardJadwal(context, jadwal);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // DESAIN KARTU JADWAL (Sudah Di-Upgrade Fitur Bunglon & Nama Dosen!)
  // =======================================================
  Widget _buildCardJadwal(BuildContext context, JadwalKuliah jadwal) {
    // Kita panggil FutureBuilder untuk ngecek status spesifik hari ini
    return FutureBuilder<JadwalException?>(
        future: isarService.cekPengecualian(jadwal.id, DateTime.now()),
        builder: (context, snapshot) {
          final exception = snapshot.data;
          final status = exception?.status ?? 'offline';
          final keterangan = exception?.keterangan ?? '';

          // Atur gaya visual (Warna) berdasarkan status
          Color warnaAksen = Theme.of(context).colorScheme.primary;
          Color warnaBackground = Colors.white;
          double opacityKartu = 1.0;

          if (status == 'libur') {
            warnaAksen = Colors.red;
            warnaBackground = Colors.grey.shade50;
            opacityKartu = 0.6; // Bikin agak pudar biar kelihatan "non-aktif"
          } else if (status == 'online') {
            warnaAksen = Colors.orange;
            warnaBackground = Colors.orange.shade50; // Background agak kekuningan biar ngejreng
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => _bukaPengaturanStatus(jadwal),
              borderRadius: BorderRadius.circular(24),
              child: Opacity(
                opacity: opacityKartu,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: warnaBackground,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Garis warna di sebelah kiri
                      Container(
                        width: 4, height: status == 'offline' ? 50 : 70, // Agak panjang kalau online/libur
                        decoration: BoxDecoration(color: warnaAksen, borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                      jadwal.namaMatkul ?? 'Matkul Tidak Diketahui',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        decoration: status == 'libur' ? TextDecoration.lineThrough : null, // Coret kalau libur
                                      )
                                  ),
                                ),
                                // ICON TITIK TIGA DI POJOK KANAN ATAS
                                const Icon(Icons.more_vert_rounded, color: Colors.grey, size: 20),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // BADGE STATUS (MUNCUL KALAU ONLINE / LIBUR SAJA)
                            if (status == 'online') ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(6)),
                                child: const Text('🌐 KELAS ONLINE', style: TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 8),
                            ],
                            if (status == 'libur') ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(6)),
                                child: const Text('🔴 DOSEN LIBUR', style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 8),
                            ],

                            Row(
                              children: [
                                Icon(Icons.access_time_rounded, size: 16, color: Colors.grey[500]),
                                const SizedBox(width: 6),
                                Text('${jadwal.jamMulai} - ${jadwal.jamSelesai}', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // ========================================================
                            // INI BAGIAN YANG BARU SAJA DIUBAH (RUANGAN + DOSEN)
                            // ========================================================
                            Row(
                              children: [
                                // 1. Bagian Ruangan / Keterangan Online & Libur
                                Icon(
                                    status == 'online' ? Icons.link_rounded : (status == 'libur' ? Icons.info_outline_rounded : Icons.meeting_room_rounded),
                                    size: 16,
                                    color: Colors.grey[500]
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    status == 'online' ? (keterangan.isNotEmpty ? keterangan : 'Link belum diisi')
                                        : status == 'libur' ? (keterangan.isNotEmpty ? keterangan : 'Tidak ada keterangan')
                                        : (jadwal.ruangan ?? '-'),
                                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                const SizedBox(width: 12), // Spasi pemisah

                                // 2. Bagian Nama Dosen
                                Icon(Icons.person_outline_rounded, size: 16, color: Colors.grey[500]),
                                const SizedBox(width: 6),
                                Expanded(
                                  flex: 1, // Berbagi tempat 50:50 dengan Ruangan/Link
                                  child: Text(
                                    jadwal.dosen ?? '-',
                                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            // ========================================================

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}