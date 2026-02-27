import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Jangan lupa import ini!

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  // Variabel state sementara untuk UI
  bool _notifAktif = true;
  int _menitSebelum = 15;

  @override
  void initState() {
    super.initState();
    _muatPengaturan(); // Baca ingatan HP saat halaman dibuka
  }

  // Fungsi membaca memori HP
  Future<void> _muatPengaturan() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifAktif = prefs.getBool('notif_aktif') ?? true;
      _menitSebelum = prefs.getInt('pengingat_menit') ?? 15;
    });
  }

  // Fungsi menyimpan perubahan menit
  Future<void> _simpanMenit(int menit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pengingat_menit', menit);
    setState(() {
      _menitSebelum = menit;
    });
  }

  // Fungsi menyimpan perubahan saklar (toggle)
  Future<void> _simpanNotifAktif(bool aktif) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_aktif', aktif);
    setState(() {
      _notifAktif = aktif;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Background abu terang
      appBar: AppBar(
        title: const Text('Pengaturan Notifikasi', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.notifications_active_rounded, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Pengingat Matkul',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Switch(
                      value: _notifAktif,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (val) {
                        _simpanNotifAktif(val); // Simpan status toggle
                      },
                    ),
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),

                Text(
                  'Ingatkan saya sebelum kelas dimulai:',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: _menitSebelum,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    fillColor: _notifAktif ? Colors.transparent : Colors.grey.shade100,
                  ),
                  items: [5, 10, 15, 30, 60].map((menit) {
                    return DropdownMenuItem(
                      value: menit,
                      child: Text(
                        menit == 60 ? '1 Jam sebelumnya' : '$menit Menit sebelumnya',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: _notifAktif
                      ? (val) {
                    if (val != null) _simpanMenit(val); // Simpan pilihan menit
                  }
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '💡 Tips: Pastikan aplikasi MiawMatkul diizinkan berjalan di latar belakang (background) pada pengaturan HP-mu agar alarm berbunyi tepat waktu.',
            style: TextStyle(fontSize: 13, color: Colors.grey[500], fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}