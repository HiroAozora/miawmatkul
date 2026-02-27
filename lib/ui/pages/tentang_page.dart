import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  // Fungsi untuk buka link profil GitHub
  Future<void> _bukaGitHub() async {
    final Uri url = Uri.parse('https://github.com/HiroAozora');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Gagal membuka link');
    }
  }

  // Fungsi pura-pura cek update
  void _cekPembaruan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text('MiawMatkul dah versi paling baru ini'),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Tentang Aplikasi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // ================= LOGO & VERSI =================
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))
                    ]
                ),
                child: SvgPicture.asset('assets/images/miawmatkul.svg', width: 90, height: 90),
              ),
              const SizedBox(height: 24),
              const Text('MiawMatkul', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87, letterSpacing: 0.5)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(20)),
                child: Text('Versi 1.0.0', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer)),
              ),
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'aplikasi jadwal matkul biar ga lupa. sukak kali pun lupa sama jadwal, giliran orang lama susah kali ya lupanya.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.6),
                ),
              ),
              const SizedBox(height: 32),

              // ================= MENU TOMBOL =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.system_update_rounded, color: Colors.black87),
                        title: const Text('Cek Pembaruan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                        onTap: () => _cekPembaruan(context),
                      ),
                      const Divider(height: 1, indent: 50),
                      ListTile(
                        leading: const Icon(Icons.gavel_rounded, color: Colors.black87),
                        title: const Text('Lisensi Open Source', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                        onTap: () {
                          showLicensePage(
                            context: context,
                            applicationName: 'MiawMatkul',
                            applicationVersion: '1.0.0',
                            applicationIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('assets/images/miawmatkul.svg', width: 48),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // ================= TECH STACK =================
              const Text('Tech Stack & Tools', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTechChip('Flutter'),
                  _buildTechChip('Dart'),
                  _buildTechChip('Isar Database'),
                  _buildTechChip('Firebase'),
                  // _buildTechChip('Figma'),
                ],
              ),
              const SizedBox(height: 48),

              // ================= FOOTER "SAKIT PINGGANG" =================
              const Text('Dibuat dengan sakit pinggang oleh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black54)),
              const SizedBox(height: 12),

              // CHIP GITHUB CLICKABLE
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _bukaGitHub, // <--- Ini yang bikin bisa dipencet!
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xFF24292E), // Warna hitam/abu gelap khas GitHub
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4))
                        ]
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Placeholder Icon GitHub (Pake icon code dulu)
                        Icon(Icons.code_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                            'hiromalasngedit',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text('Mahasiswa Ilmu Komputer UINSU', style: TextStyle(fontSize: 12, color: Colors.grey[400])),
            ],
          ),
        ),
      ),
    );
  }

  // Widget kecil buat bikin desain Tech Stack
  Widget _buildTechChip(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
    );
  }
}