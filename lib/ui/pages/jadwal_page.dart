import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../models/jadwal.dart';
import '../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/notification_service.dart';
import '../widgets/status_kelas_sheet.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  final List<String> _tabList = ['Tabel', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];

  // 1. Variabel penampung nama ruangan dari Firebase
  List<String> _saranRuangan = [];

  // 2. Fungsi bawaan Flutter yang dipanggil pertama kali saat halaman dibuka
  @override
  void initState() {
    super.initState();
    _muatSaranRuangan();
  }

  // 3. Fungsi narik data ruangan
  Future<void> _muatSaranRuangan() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('ruangan').get();
      setState(() {
        _saranRuangan = snapshot.docs.map((doc) => doc['nama_ruangan'].toString()).toList();
      });
    } catch (e) {
      debugPrint("Gagal muat ruangan: $e");
    }
  }

  // =======================================================
  // FITUR BARU: FUNGSI PINTAR UNTUK MENCARI TANGGAL TERDEKAT
  // =======================================================
  DateTime _dapatkanTanggalTerdekat(String hariTarget) {
    final now = DateTime.now();
    int targetHari = 1;
    switch (hariTarget.toLowerCase()) {
      case 'senin': targetHari = 1; break;
      case 'selasa': targetHari = 2; break;
      case 'rabu': targetHari = 3; break;
      case 'kamis': targetHari = 4; break;
      case 'jumat': targetHari = 5; break;
      case 'sabtu': targetHari = 6; break;
      case 'minggu': targetHari = 7; break;
    }

    int selisihHari = targetHari - now.weekday;
    if (selisihHari < 0) {
      selisihHari += 7; // Kalau harinya udah lewat, ambil minggu depan
    }
    return now.add(Duration(days: selisihHari));
  }

  // =======================================================
  // FITUR BARU: MENU PILIHAN SAAT KARTU DIKLIK
  // =======================================================
  void _tampilkanPilihanEdit(JadwalKuliah jadwal) {
    DateTime tanggalTarget = _dapatkanTanggalTerdekat(jadwal.hari ?? 'Senin');

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Pilih Aksi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Opsi 1: Ubah Status (Online/Libur)
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.event_available_rounded, color: Colors.blue),
                    ),
                    title: const Text('Ubah Status Kelas', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Set Online / Libur untuk ${tanggalTarget.day}/${tanggalTarget.month}/${tanggalTarget.year}'),
                    onTap: () {
                      Navigator.pop(context); // Tutup menu pilihan

                      // Buka Smart Pop-up Status Kelas
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => StatusKelasSheet(
                          jadwal: jadwal,
                          tanggal: tanggalTarget,
                          isarService: isarService,
                        ),
                      ).then((_) => setState(() {})); // Refresh setelah save
                    },
                  ),

                  const Divider(),

                  // Opsi 2: Edit Jadwal Rutin (Form Lama)
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.edit_calendar_rounded, color: Colors.orange),
                    ),
                    title: const Text('Edit Jadwal Rutin', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Ubah jam, ruangan, atau dosen secara permanen'),
                    onTap: () {
                      Navigator.pop(context); // Tutup menu pilihan
                      _tampilkanFormJadwal(context, jadwalLama: jadwal);
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _tampilkanFormJadwal(context);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Jadwal', style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: DefaultTabController(
        length: _tabList.length,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).colorScheme.primary,
                indicatorWeight: 3,
                labelColor: Theme.of(context).colorScheme.primary,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.grey[400],
                tabs: _tabList.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _tabList.map((tab) {
                  if (tab == 'Tabel') return _buildTabelJadwalFull();
                  return _buildJadwalPerHari(tab);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabelJadwalFull() {
    return FutureBuilder<List<JadwalKuliah>>(
        future: isarService.ambilSemuaJadwal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tabel kosong, belum ada jadwal masuk 🗓️', style: TextStyle(color: Colors.grey[500])));
          }

          final semuaJadwal = snapshot.data!;
          final List<String> days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];

          const double startHour = 7.0;
          const double endHour = 18.0;
          const double hourWidth = 110.0;
          const double dayRowHeight = 85.0;

          double parseTime(String? timeStr) {
            if (timeStr == null || !timeStr.contains(':')) return startHour;
            try {
              final parts = timeStr.split(':');
              return double.parse(parts[0]) + (double.parse(parts[1]) / 60.0);
            } catch (e) {
              return startHour;
            }
          }

          return SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: Colors.grey.shade300)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(2, 0))],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      ...days.map((day) => Container(
                        height: dayRowHeight,
                        alignment: Alignment.center,
                        child: Text(day.substring(0, 3), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                      )).toList(),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          width: (endHour - startHour) * hourWidth,
                          color: const Color(0xFFF8F9FA),
                          child: Stack(
                            children: List.generate((endHour - startHour + 1).toInt(), (index) {
                              return Positioned(
                                left: index * hourWidth,
                                child: Container(
                                  width: hourWidth,
                                  padding: const EdgeInsets.only(left: 6, top: 8),
                                  decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.grey.shade300))),
                                  child: Text('${(startHour + index).toInt().toString().padLeft(2, '0')}:00', style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                              );
                            }),
                          ),
                        ),

                        ...days.map((day) {
                          final jadwalHariIni = semuaJadwal.where((j) => j.hari == day).toList();

                          return Container(
                            height: dayRowHeight,
                            width: (endHour - startHour) * hourWidth,
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                            child: Stack(
                              children: [
                                ...List.generate((endHour - startHour).toInt(), (index) {
                                  return Positioned(
                                    left: index * hourWidth,
                                    top: 0, bottom: 0,
                                    child: Container(width: hourWidth, decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.grey.shade100, style: BorderStyle.solid)))),
                                  );
                                }),

                                ...jadwalHariIni.map((jadwal) {
                                  final start = parseTime(jadwal.jamMulai);
                                  final end = parseTime(jadwal.jamSelesai);
                                  final duration = end - start;
                                  final leftPosition = (start - startHour) * hourWidth;
                                  final blockWidth = duration * hourWidth;

                                  return Positioned(
                                    left: leftPosition,
                                    top: 8,
                                    child: GestureDetector(
                                      // ======= UBAH ONTAP DI TABEL DI SINI =======
                                      onTap: () {
                                        _tampilkanPilihanEdit(jadwal);
                                      },
                                      child: Container(
                                        width: blockWidth > 0 ? blockWidth : hourWidth,
                                        height: dayRowHeight - 16,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primaryContainer,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(jadwal.namaMatkul ?? '-', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                                            const SizedBox(height: 2),
                                            Text('${jadwal.ruangan} | ${jadwal.dosen}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildJadwalPerHari(String hari) {
    return FutureBuilder<List<JadwalKuliah>>(
      future: isarService.ambilJadwalHari(hari),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('Kosong nih hari $hari 🗓️', style: TextStyle(color: Colors.grey[500])));

        final jadwalList = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: jadwalList.length,
          itemBuilder: (context, index) {
            final jadwal = jadwalList[index];
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
              child: ListTile(
                // ======= UBAH ONTAP DI LIST HARI DI SINI =======
                onTap: () {
                  _tampilkanPilihanEdit(jadwal);
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                title: Text(jadwal.namaMatkul ?? '-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Baris 1: Jam
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Text(
                            '${jadwal.jamMulai} - ${jadwal.jamSelesai}',
                            style: TextStyle(color: Colors.grey[700], fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Baris 2: Ruangan & Dosen (Berdampingan)
                      Row(
                        children: [
                          // Bagian Ruangan
                          Icon(Icons.meeting_room_rounded, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Flexible(
                            flex: 1, // Ruangan biasanya pendek (misal: "401"), jadi porsinya cukup 1
                            child: Text(
                              jadwal.ruangan ?? '-',
                              style: TextStyle(color: Colors.grey[700], fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(width: 12), // Spasi pemisah antara ruangan dan dosen

                          // Bagian Dosen
                          Icon(Icons.person_outline_rounded, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Expanded(
                            flex: 2, // Nama dosen biasanya panjang, jadi kita kasih porsi ruang 2x lebih besar
                            child: Text(
                              jadwal.dosen ?? '-',
                              style: TextStyle(color: Colors.grey[700], fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Mengubah icon edit jadi titik tiga untuk nunjukkin ada "menu" (opsional)
                trailing: const Icon(Icons.more_vert_rounded, color: Colors.grey),
              ),
            );
          },
        );
      },
    );
  }

  void _tampilkanFormJadwal(BuildContext context, {JadwalKuliah? jadwalLama}) {
    final bool isEdit = jadwalLama != null;

    TimeOfDay parseStringToTime(String? timeStr) {
      if (timeStr == null || !timeStr.contains(':')) return const TimeOfDay(hour: 8, minute: 0);
      final parts = timeStr.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    final matkulController = TextEditingController(text: isEdit ? jadwalLama.namaMatkul : '');
    final ruanganController = TextEditingController(text: isEdit ? jadwalLama.ruangan : '');
    final dosenController = TextEditingController(text: isEdit ? jadwalLama.dosen : '');

    String hariTerpilih = isEdit ? (jadwalLama.hari ?? 'Senin') : 'Senin';
    TimeOfDay jamMulaiTerpilih = isEdit ? parseStringToTime(jadwalLama.jamMulai) : const TimeOfDay(hour: 8, minute: 0);
    TimeOfDay jamSelesaiTerpilih = isEdit ? parseStringToTime(jadwalLama.jamSelesai) : const TimeOfDay(hour: 10, minute: 0);

    String formatJam(TimeOfDay time) {
      final jam = time.hour.toString().padLeft(2, '0');
      final menit = time.minute.toString().padLeft(2, '0');
      return '$jam:$menit';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setFormState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: EdgeInsets.only(
                left: 24, right: 24, top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)))),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isEdit ? Icons.edit_calendar_rounded : Icons.post_add_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 26,
                            ),
                            const SizedBox(width: 10),
                            Text(
                                isEdit ? 'Edit Jadwal' : 'Tambah Jadwal',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),

                        if (isEdit)
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                            onPressed: () async {
                              await isarService.hapusJadwal(jadwalLama.id);
                              await notificationService.batalkanPengingat(jadwalLama.id);
                              if (context.mounted) Navigator.pop(context);
                              setState(() {});
                              if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Jadwal dihapus!')));
                            },
                          )
                      ],
                    ),
                    const SizedBox(height: 24),

                    DropdownButtonFormField<String>(
                      value: hariTerpilih,
                      decoration: InputDecoration(labelText: 'Hari', prefixIcon: const Icon(Icons.calendar_today_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
                      items: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'].map((hari) => DropdownMenuItem(value: hari, child: Text(hari))).toList(),
                      onChanged: (value) => setFormState(() => hariTerpilih = value!),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(controller: matkulController, decoration: InputDecoration(labelText: 'Mata Kuliah', prefixIcon: const Icon(Icons.book_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)))),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(child: InkWell(onTap: () async { final picked = await showTimePicker(context: context, initialTime: jamMulaiTerpilih); if (picked != null) setFormState(() => jamMulaiTerpilih = picked); }, child: InputDecorator(decoration: InputDecoration(labelText: 'Jam Mulai', prefixIcon: const Icon(Icons.access_time_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))), child: Text(formatJam(jamMulaiTerpilih), style: const TextStyle(fontSize: 16))))),
                        const SizedBox(width: 16),
                        Expanded(child: InkWell(onTap: () async { final picked = await showTimePicker(context: context, initialTime: jamSelesaiTerpilih); if (picked != null) setFormState(() => jamSelesaiTerpilih = picked); }, child: InputDecorator(decoration: InputDecoration(labelText: 'Jam Selesai', border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))), child: Text(formatJam(jamSelesaiTerpilih), style: const TextStyle(fontSize: 16))))),
                      ],
                    ),
                    const SizedBox(height: 16),

                    LayoutBuilder(
                        builder: (context, constraints) {
                          return DropdownMenu<String>(
                            controller: ruanganController,
                            width: constraints.maxWidth,
                            enableFilter: true,
                            requestFocusOnTap: true,
                            label: const Text('Ruangan (Pilih / Ketik)'),
                            leadingIcon: const Icon(Icons.meeting_room_rounded),
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                            dropdownMenuEntries: _saranRuangan.map<DropdownMenuEntry<String>>((String nama) {
                              return DropdownMenuEntry<String>(
                                value: nama,
                                label: nama,
                              );
                            }).toList(),
                            onSelected: (String? value) {
                              if (value != null) {
                                ruanganController.text = value;
                              }
                            },
                          );
                        }
                    ),

                    const SizedBox(height: 16),
                    TextFormField(controller: dosenController, decoration: InputDecoration(labelText: 'Dosen Pengampu', prefixIcon: const Icon(Icons.person_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)))),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity, height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                        onPressed: () async {
                          if (matkulController.text.isEmpty) return;

                          final jadwalBaru = JadwalKuliah()
                            ..id = isEdit ? jadwalLama.id : Isar.autoIncrement
                            ..firestoreId = isEdit ? jadwalLama.firestoreId : DateTime.now().millisecondsSinceEpoch.toString()
                            ..hari = hariTerpilih
                            ..namaMatkul = matkulController.text
                            ..dosen = dosenController.text
                            ..ruangan = ruanganController.text
                            ..jamMulai = formatJam(jamMulaiTerpilih)
                            ..jamSelesai = formatJam(jamSelesaiTerpilih)
                            ..isSubscribed = true;

                          await isarService.tambahJadwal(jadwalBaru);
                          await notificationService.jadwalkanPengingat(
                              id: jadwalBaru.id,
                              namaMatkul: jadwalBaru.namaMatkul ?? 'Matkul',
                              ruangan: jadwalBaru.ruangan ?? 'Ruangan',
                              hari: jadwalBaru.hari ?? 'Senin',
                              jamMulai: jadwalBaru.jamMulai ?? '08:00'
                          );

                          if (context.mounted) Navigator.pop(context);
                          setState(() {});
                        },
                        child: Text(isEdit ? 'Update Jadwal' : 'Simpan Jadwal', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}