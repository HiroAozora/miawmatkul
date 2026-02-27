import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notif_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {},
    );

    // NOTE: Do NOT await permission requests here — they open system dialogs/settings
    // which require an Activity to exist. Since init() is called before runApp(),
    // awaiting them causes the app to hang at splash screen forever.
    // Fire-and-forget: permissions will be requested in the background.
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }

  Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'miawmatkul_channel',
          'Jadwal Kuliah',
          channelDescription: 'Notifikasi pengingat jadwal kuliah MiawMatkul',
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Tes Mesin Notifikasi 🐾',
      body: 'Halo! Mesin alarm MiawMatkul sudah berhasil di-install.',
      notificationDetails: platformChannelSpecifics,
    );
  }

  int _angkaHari(String hari) {
    switch (hari.toLowerCase()) {
      case 'senin':
        return 1;
      case 'selasa':
        return 2;
      case 'rabu':
        return 3;
      case 'kamis':
        return 4;
      case 'jumat':
        return 5;
      case 'sabtu':
        return 6;
      case 'minggu':
        return 7;
      default:
        return 1;
    }
  }

  Future<void> jadwalkanPengingat({
    required int id,
    required String namaMatkul,
    required String ruangan,
    required String hari,
    required String jamMulai,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Cek apakah toggle notif di Pengaturan sedang aktif
    final bool isAktif = prefs.getBool('notif_aktif') ?? true;
    if (!isAktif) {
      print('❌ DEBUG: Notifikasi dimatikan di pengaturan. Batal pasang alarm.');
      return;
    } // Kalau mati, batal masang alarm

    final parts = jamMulai.split(':');
    final jam = int.parse(parts[0]);
    final menit = int.parse(parts[1]);
    final targetHari = _angkaHari(hari);

    final now = tz.TZDateTime.now(tz.getLocation('Asia/Jakarta'));
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.getLocation('Asia/Jakarta'),
      now.year,
      now.month,
      now.day,
      jam,
      menit,
    );

    while (scheduledDate.weekday != targetHari) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // Tarik info menit dari pengaturan
    final int menitSebelum = prefs.getInt('pengingat_menit') ?? 15;

    // Mundurkan waktu
    scheduledDate = scheduledDate.subtract(Duration(minutes: menitSebelum));

    print('\n====== 🕵️‍♂️ CCTV NOTIFIKASI 🕵️‍♂️ ======');
    print('▶️ Matkul: $namaMatkul');
    print('▶️ Waktu HP Sekarang: $now');
    print(
      '▶️ Target Asli Alarm: $scheduledDate (Sudah dikurangi $menitSebelum menit)',
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
      print(
        '⚠️ PERINGATAN: Karena jam target sudah lewat, alarm dilempar ke minggu depan!',
      );
      print('▶️ Target Baru Alarm: $scheduledDate');
    } else {
      print('✅ MANTAP: Alarm valid dan aktif! Menunggu waktu berbunyi...');
    }
    print('=====================================\n');

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'jadwal_rutin',
          'Pengingat Kuliah',
          channelDescription: 'Alarm sebelum kuliah dimulai',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: 'Persiapan Kuliah! 🐾',
      body:
          'Matkul $namaMatkul di $ruangan mulai $menitSebelum menit lagi. Gass!', // Teks Dinamis
      scheduledDate: scheduledDate,
      notificationDetails: platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> batalkanPengingat(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id: id);
  }

  // =======================================================
  // FITUR BARU: ALARM KHUSUS (ONLINE / LIBUR)
  // =======================================================
  // =======================================================
  // FITUR BARU: ALARM KHUSUS (ONLINE / LIBUR)
  // =======================================================
  Future<void> aturAlarmPengecualian({
    required int id,
    required String namaMatkul,
    required String ruangan,
    required String hari,
    required String jamMulai,
    required String status,
    required String keterangan,
    required DateTime tanggalTarget,
  }) async {
    // 1. BUNUH ALARM RUTINNYA (Biar nggak dobel atau bunyi pas libur)
    await batalkanPengingat(id);
    await batalkanPengingat(
      id + 10000,
    ); // Bersihkan sisa alarm khusus sebelumnya

    final prefs = await SharedPreferences.getInstance();
    final bool isAktif = prefs.getBool('notif_aktif') ?? true;
    if (!isAktif) return;

    final parts = jamMulai.split(':');
    final jam = int.parse(parts[0]);
    final menit = int.parse(parts[1]);
    final int menitSebelum = prefs.getInt('pengingat_menit') ?? 15;
    final now = tz.TZDateTime.now(tz.getLocation('Asia/Jakarta'));

    // Hitung target waktu alarm berbunyi
    tz.TZDateTime jadwalKhusus = tz.TZDateTime(
      tz.getLocation('Asia/Jakarta'),
      tanggalTarget.year,
      tanggalTarget.month,
      tanggalTarget.day,
      jam,
      menit,
    );
    jadwalKhusus = jadwalKhusus.subtract(Duration(minutes: menitSebelum));

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'jadwal_rutin',
          'Pengingat Kuliah',
          channelDescription: 'Alarm sebelum kuliah dimulai',
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    // 2. JIKA ONLINE: PASANG ALARM "SEKALI TEMBAK" HARI INI SAJA
    if (status == 'online' && jadwalKhusus.isAfter(now)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id: id + 10000, // ID khusus, beda dengan ID alarm rutin
        title: '🌐 Kelas Online: $namaMatkul',
        body:
            'Mulai $menitSebelum menit lagi. Link: ${keterangan.isEmpty ? "Cek di grup ya!" : keterangan}',
        scheduledDate: jadwalKhusus,
        notificationDetails: platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        // PERHATIKAN: Tidak ada matchDateTimeComponents di sini.
        // Artinya alarm ini murni cuma bunyi 1x dan nggak akan mengulang minggu depan!
      );
    }

    // 3. JIKA LIBUR:
    // Sistem otomatis diam. Alarm rutin mati, alarm khusus nggak dipasang. HP aman tentram!
  }
}

final notificationService = NotificationService();
