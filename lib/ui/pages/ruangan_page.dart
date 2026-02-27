import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RuanganPage extends StatefulWidget {
  const RuanganPage({super.key});

  @override
  State<RuanganPage> createState() => _RuanganPageState();
}

class _RuanganPageState extends State<RuanganPage> {
  // Daftar kategori gedung (Tab)
  final List<String> _kategoriGedung = ['Semua', 'Saintek', 'Perpus', 'FKM', 'FIS', 'FEBI', 'Lab'];

  // Variabel untuk Dropdown Kampus (Buat persiapan masa depan)
  String _kampusTerpilih = 'Kampus IV Tuntungan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown simulasi buat ganti kampus ntar
            Text('📍 $_kampusTerpilih', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.map_rounded, color: Colors.black54),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Peta visual kampus segera hadir! 🗺️')));
            },
          )
        ],
      ),

      // Bungkus pakai DefaultTabController buat navigasi geser
      body: DefaultTabController(
        length: _kategoriGedung.length,
        child: Column(
          children: [
            // ================= TAB BAR (Kategori Gedung) =================
            Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).colorScheme.primary,
                indicatorWeight: 3,
                labelColor: Theme.of(context).colorScheme.primary,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey[400],
                tabs: _kategoriGedung.map((kategori) => Tab(text: kategori)).toList(),
              ),
            ),

            // ================= STREAM BUILDER (Narik Data Sekali Aja) =================
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // Nanti kalau mau khusus Tuntungan aja, query-nya bisa ditambah:
                // .where('kampus', isEqualTo: 'Kampus 4 Tuntungan')
                stream: FirebaseFirestore.instance.collection('ruangan').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Waduh, error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Belum ada data ruangan 🐾', style: TextStyle(color: Colors.grey[500])));
                  }

                  // Semua data mentah dari Firebase
                  final semuaRuangan = snapshot.data!.docs;

                  // ================= ISI TAB VIEW =================
                  return TabBarView(
                    children: _kategoriGedung.map((kategori) {

                      // LOGIKA FILTERING: Pisahkan data berdasarkan tab yang aktif
                      List<QueryDocumentSnapshot> ruanganTampil = semuaRuangan;

                      if (kategori != 'Semua') {
                        ruanganTampil = semuaRuangan.where((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final namaGedung = (data['gedung'] ?? '').toString().toLowerCase();
                          // Ngecek apakah nama gedung di Firebase mengandung kata 'saintek', 'perpus', dll
                          return namaGedung.contains(kategori.toLowerCase());
                        }).toList();
                      }

                      // Kalau setelah difilter ternyata kosong
                      if (ruanganTampil.isEmpty) {
                        return Center(
                          child: Text('Belum ada data untuk gedung $kategori 🏢', style: TextStyle(color: Colors.grey[400])),
                        );
                      }

                      // Tampilkan list ruangan yang sudah difilter
                      return ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: ruanganTampil.length,
                        itemBuilder: (context, index) {
                          final room = ruanganTampil[index].data() as Map<String, dynamic>;

                          final nama = room['nama_ruangan'] ?? 'Tanpa Nama';
                          final gedung = room['gedung'] ?? '-';
                          final lantai = room['lantai']?.toString() ?? '-';
                          final kampus = room['kampus'] ?? 'Kampus Tidak Diketahui';
                          final deskripsi = room['deskripsi'] ?? 'Tidak ada deskripsi.';
                          final aktif = room['is_active'] ?? false;

                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.shade200)),
                            color: aktif ? Colors.white : Colors.grey.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(kampus.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5, color: Theme.of(context).colorScheme.primary))),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(color: aktif ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                                        child: Text(aktif ? 'Tersedia' : 'Ditutup', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: aktif ? Colors.green : Colors.red)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(nama, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                                  const SizedBox(height: 4),
                                  Text('Gedung $gedung • Lantai $lantai', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
                                  const Text('Deskripsi:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                                  const SizedBox(height: 4),
                                  Text(deskripsi, style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4)),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}