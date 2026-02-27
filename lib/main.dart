import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'firebase_options.dart';
import 'models/jadwal.dart';
import 'services/isar_service.dart';
import 'ui/pages/beranda_page.dart';
import 'ui/pages/jadwal_page.dart';
import 'ui/pages/pengaturan_page.dart';
import 'ui/pages/profil_page.dart';
import 'ui/pages/ruangan_page.dart';
import 'ui/pages/template_page.dart';
import 'services/notification_service.dart';
import 'models/jadwal_exception.dart';

late Isar isar;
late IsarService isarService;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };

      await initializeDateFormatting('id_ID', null);
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([
        JadwalKuliahSchema,
        JadwalExceptionSchema,
      ], directory: dir.path);
      isarService = IsarService(isar);

      try {
        await notificationService.init();
      } catch (e) {
        // Notification init failure is non-fatal — app can work without it
        debugPrint('Notification init error: $e');
      }

      runApp(const MiawMatkulApp());
    },
    (error, stack) {
      debugPrint('FATAL ERROR: $error\n$stack');
    },
  );
}

class MiawMatkulApp extends StatelessWidget {
  const MiawMatkulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiawMatkul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16A085)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const MainPage(),
    );
  }
}

// ================= AREA TAMPILAN UTAMA =================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // 1. Siapkan 5 Halaman Sesuai Flow Kamu
  final List<Widget> _pages = [
    const BerandaPage(),
    const JadwalPage(),
    const RuanganPage(),
    const TemplatePage(),
    const ProfilPage(),
  ];

  // 2. Daftar Judul AppBar
  final List<String> _appBarTitles = [
    'MiawMatkul', // Ini buat jaga-jaga, tapi nanti diganti sama SVG di UI
    'Jadwal Mingguan',
    'Denah Ruangan',
    'Template Jadwal',
    'Profilku',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      // ================= APP BAR (HEADER) =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ==========================================================
        // FITUR BARU: LOGIKA HEADER BERUBAH SESUAI TAB
        // ==========================================================
        title: _selectedIndex == 0
            ? Row(
                children: [
                  // Logo SVG muncul khusus di Beranda
                  SvgPicture.asset(
                    'assets/images/miawmatkul.svg',
                    width: 56,
                    height: 56,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'MiawMatkul',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.w900, // Font ditebalkan biar kayak logo
                      letterSpacing: 0.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              )
            : Text(
                _appBarTitles[_selectedIndex], // Munculkan teks biasa di tab lain
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
        // ==========================================================
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.black54),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PengaturanPage()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ================= ISI HALAMAN =================
      // ================= ISI HALAMAN (DENGAN ANIMASI) =================
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0), // Efek geser sedikit dari kanan
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        // ValueKey penting agar Flutter sadar halamannya berubah
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _pages[_selectedIndex],
        ),
      ),

      // ================= BOTTOM NAV BAR =================
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            // --- INI RAHASIA ANIMASINYA ---
            showSelectedLabels: true, // Munculkan teks SAAT DIPILIH
            showUnselectedLabels: false, // Sembunyikan teks JIKA TIDAK DIPILIH
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            // ------------------------------
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey[400],
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded, size: 24),
                activeIcon: Icon(
                  Icons.home_rounded,
                  size: 28,
                ), // Ukuran icon aktif dikecilin dikit ngalah sama teks
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded, size: 24),
                activeIcon: Icon(Icons.calendar_month_rounded, size: 28),
                label: 'Jadwal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.meeting_room_rounded, size: 24),
                activeIcon: Icon(Icons.meeting_room_rounded, size: 28),
                label: 'Ruangan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize_rounded, size: 24),
                activeIcon: Icon(Icons.dashboard_customize_rounded, size: 28),
                label: 'Template',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded, size: 24),
                activeIcon: Icon(Icons.person_rounded, size: 28),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
