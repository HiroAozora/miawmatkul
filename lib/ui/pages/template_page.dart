import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import '../../models/jadwal.dart';
import '../../main.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({super.key});

  // Fungsi untuk memasukkan jadwal dari Firebase ke Isar lokal
  Future<void> _imporJadwalKeLokal(BuildContext context, List<dynamic> daftarMatkul) async {
    // Tampilkan loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Looping semua matkul di dalam array template
      for (var matkul in daftarMatkul) {
        final dataMatkul = matkul as Map<String, dynamic>;

        final jadwalBaru = JadwalKuliah()
          ..id = Isar.autoIncrement
          ..firestoreId = DateTime.now().millisecondsSinceEpoch.toString() + matkul.hashCode.toString() // Biar ID unik
          ..hari = dataMatkul['hari'] ?? 'Senin'
          ..namaMatkul = dataMatkul['nama_matkul'] ?? 'Tanpa Nama'
          ..dosen = dataMatkul['dosen'] ?? '-'
          ..ruangan = dataMatkul['ruangan'] ?? '-'
          ..jamMulai = dataMatkul['jam_mulai'] ?? '08:00'
          ..jamSelesai = dataMatkul['jam_selesai'] ?? '10:00'
          ..isSubscribed = true;

        await isarService.tambahJadwal(jadwalBaru);
      }

      // Tutup loading
      if (context.mounted) Navigator.pop(context);

      // Kasih tahu kalau sukses
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Yeay! Jadwal berhasil diimpor ke HP-mu! 🎉'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context); // Tutup loading kalau error
      debugPrint("Error impor: $e");
    }
  }

  // Pop-up Konfirmasi sebelum impor
  void _konfirmasiImpor(BuildContext context, Map<String, dynamic> dataTemplate) {
    final namaKelas = dataTemplate['kelas'] ?? 'Kelas';
    final daftarMatkul = dataTemplate['daftar_matkul'] as List<dynamic>? ?? [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Impor Jadwal $namaKelas?'),
        content: Text('Ada ${daftarMatkul.length} mata kuliah di template ini. Apakah kamu mau memasukkannya ke jadwal pribadimu?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context); // Tutup dialog konfirmasi
              _imporJadwalKeLokal(context, daftarMatkul); // Eksekusi fungsi impor
            },
            child: const Text('Ya, Impor Semua'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Pilih sesuai kelas yang tersedia, kalo gada bikin sendiri aja ya', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87, fontSize: 14)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('template_jadwal').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Waduh, error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Belum ada template dari prodi 🐾', style: TextStyle(color: Colors.grey[500])));
          }

          final templateList = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: templateList.length,
            itemBuilder: (context, index) {
              final template = templateList[index].data() as Map<String, dynamic>;

              final kelas = template['kelas'] ?? 'Tanpa Nama';
              final prodi = template['program_studi'] ?? '-';
              final semester = template['semester']?.toString() ?? '-';
              final daftarMatkul = template['daftar_matkul'] as List<dynamic>? ?? [];

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.grey.shade200)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(Icons.school_rounded, color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kelas $kelas', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                                const SizedBox(height: 4),
                                Text('$prodi • Semester $semester', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(height: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${daftarMatkul.length} Mata Kuliah', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                          ElevatedButton.icon(
                            onPressed: () => _konfirmasiImpor(context, template),
                            icon: const Icon(Icons.download_rounded, size: 18),
                            label: const Text('Gunakan'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}