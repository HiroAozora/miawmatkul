import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- Import baru
import '../../main.dart';
import '../../models/jadwal.dart';
import 'tentang_page.dart';
import '../../services/notification_service.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _isDarkMode = false;

  // Data default sebelum narik dari memori
  String _nama = 'Memuat...';
  String _kelas = 'Memuat...';
  String _kampus = 'Memuat...';

  @override
  void initState() {
    super.initState();
    _muatDataProfil(); // Panggil fungsi muat data saat halaman dibuka
  }

  // Fungsi narik data dari tas kecil (SharedPreferences)
  Future<void> _muatDataProfil() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('profil_nama') ?? 'Hiro'; // Kalau kosong, defaultnya 'Hiro'
      _kelas = prefs.getString('profil_kelas') ?? 'Ilmu Komputer - IK 2';
      _kampus = prefs.getString('profil_kampus') ?? 'UINSU';
    });
  }

  // ================= FORM EDIT PROFIL (BOTTOM SHEET) =================
  void _tampilkanFormEditProfil() {
    final namaController = TextEditingController(text: _nama);
    final kelasController = TextEditingController(text: _kelas);
    final kampusController = TextEditingController(text: _kampus);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
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
              mainAxisSize: MainAxisSize.min, // Biar tingginya pas dengan isi form
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)))),
                const SizedBox(height: 20),
                const Text('Edit Profil 🐾', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),

                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama Panggilan', prefixIcon: const Icon(Icons.person_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: kelasController,
                  decoration: InputDecoration(labelText: 'Jurusan & Kelas', prefixIcon: const Icon(Icons.class_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: kampusController,
                  decoration: InputDecoration(labelText: 'Kampus', prefixIcon: const Icon(Icons.account_balance_rounded), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity, height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    onPressed: () async {
                      // Simpan ke SharedPreferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('profil_nama', namaController.text);
                      await prefs.setString('profil_kelas', kelasController.text);
                      await prefs.setString('profil_kampus', kampusController.text);

                      // Perbarui tampilan layar
                      setState(() {
                        _nama = namaController.text;
                        _kelas = kelasController.text;
                        _kampus = kampusController.text;
                      });

                      if (context.mounted) {
                        Navigator.pop(context); // Tutup form
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil berhasil diupdate! ✨')));
                      }
                    },
                    child: const Text('Simpan Profil', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ================= HEADER PROFIL =================
          Center(
            child: Column(
              children: [
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), width: 4),
                    boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Icon(Icons.person_rounded, size: 50, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 16),
                Text(_nama, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text('$_kelas | $_kampus', style: TextStyle(fontSize: 14, color: Colors.grey[600]), textAlign: TextAlign.center),
                const SizedBox(height: 16),

                // TOMBOL EDIT DIPERBARUI
                ElevatedButton.icon(
                  onPressed: () {
                    _tampilkanFormEditProfil(); // Panggil form yang baru dibuat
                  },
                  icon: const Icon(Icons.edit_rounded, size: 18),
                  label: const Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5))),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ================= MENU PREFERENSI & LAINNYA =================
          // const Text('Preferensi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          // const SizedBox(height: 12),
          // _buildMenuCard(context, icon: Icons.dark_mode_rounded, title: 'Mode Gelap (Dark Mode)', trailing: Switch(value: _isDarkMode, activeColor: Theme.of(context).colorScheme.primary, onChanged: (val) { setState(() => _isDarkMode = val); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tema dinamis menyusul ya!'))); })),
          // // _buildMenuCard(context, icon: Icons.cloud_sync_rounded, title: 'Sinkronisasi Cloud', subtitle: 'Firebase Firestore belum dikonfigurasi', onTap: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fokus MVP dulu! 🚀'))); }),
          // const SizedBox(height: 24),
          // const Text('Lainnya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          // const SizedBox(height: 12),
          // _buildMenuCard(
          //     context,
          //     icon: Icons.notifications_active_rounded,
          //     title: 'Tes Notifikasi',
          //     onTap: () {
          //       // Panggil fungsi tes tembak notifikasi
          //       notificationService.showTestNotification();
          //     }
          // ),
          _buildMenuCard(
              context,
              icon: Icons.info_outline_rounded,
              title: 'Tentang MiawMatkul',
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TentangPage()),
          );
              }
              ),
          _buildMenuCard(
            context, icon: Icons.delete_forever_rounded, title: 'Reset Semua Data', subtitle: 'Hapus seluruh jadwal dari HP ini', isDestructive: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: const Text('⚠️ Reset Data?'),
                    content: const Text('Yakin mau hapus SEMUA jadwal? Data yang sudah dihapus nggak bisa dikembalikan lagi, lho.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: Text('Batal', style: TextStyle(color: Colors.grey[600]))),
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () async { await isarService.isar.writeTxn(() async { await isarService.isar.jadwalKuliahs.clear(); }); if (context.mounted) { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Semua jadwal berhasil dibersihkan! 🧹'))); } }, child: const Text('Ya, Hapus')),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required IconData icon, required String title, String? subtitle, Widget? trailing, VoidCallback? onTap, bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: isDestructive ? Colors.red.withOpacity(0.1) : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: isDestructive ? Colors.red : Theme.of(context).colorScheme.primary)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isDestructive ? Colors.red : Colors.black87)),
        subtitle: subtitle != null ? Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[500])) : null,
        trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right_rounded, color: Colors.grey) : null),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}