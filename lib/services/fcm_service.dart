import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BACKGROUND HANDLER — harus top-level (bukan method di class)
// Dipanggil saat app di-background atau terminated.
// Annotasi @pragma wajib ada agar tidak di-strip oleh compiler di release mode.
// ─────────────────────────────────────────────────────────────────────────────
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Tidak perlu init Firebase di sini — sudah dihandle oleh SDK secara otomatis
  debugPrint(
    '📨 [FCM Background] Notif diterima: ${message.notification?.title}',
  );
  // Notifikasi background ditampilkan otomatis oleh sistem Android/FCM.
  // Tidak perlu flutter_local_notifications di sini.
}

// ─────────────────────────────────────────────────────────────────────────────
// FCM SERVICE — singleton untuk inisialisasi dan foreground handling
// ─────────────────────────────────────────────────────────────────────────────
class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Channel Android untuk notifikasi foreground via flutter_local_notifications
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'fcm_global_channel', // id — harus unik
    'Global Pengumuman', // nama yang ditampilkan di pengaturan HP
    description: 'Notifikasi pengumuman global dari MiawMatkul',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  // ───────────────────────────── INIT ─────────────────────────────────────────
  Future<void> init() async {
    // 1. Daftarkan background handler (harus sebelum apapun)
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 2. Minta izin notifikasi dari FCM (terutama untuk iOS, Android 13+)
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    // 3. Buat channel Android untuk notifikasi foreground
    await _localNotif
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    // 4. Subscribe ke topik global — semua user akan terima broadcast ini
    await _messaging.subscribeToTopic('global_users');
    debugPrint('✅ [FCM] Subscribe ke topik: global_users');

    // 5. Ambil token (opsional — untuk debug / simpan ke Firestore nanti)
    final token = await _messaging.getToken();
    debugPrint('🔑 [FCM Token]: $token');

    // 6. Pasang foreground listener
    _listenForeground();

    // 7. Handle notif yang jadi app-opener (app terminated lalu user tap notif)
    _handleInitialMessage();
  }

  // ─────────────────── FOREGROUND LISTENER ────────────────────────────────────
  // Saat app TERBUKA, FCM tidak otomatis tampil — harus tampilkan manual
  // via flutter_local_notifications.
  void _listenForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;

      debugPrint(
        '📨 [FCM Foreground] ${notification?.title}: ${notification?.body}',
      );

      if (notification != null && android != null) {
        _localNotif.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              icon: 'notif_icon', // nama drawable di res/drawable
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }

  // ─────────────────── APP OPENER HANDLER ─────────────────────────────────────
  // Jika app terminated dan user tap notifikasi — tangkap pesan pemicunya
  Future<void> _handleInitialMessage() async {
    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
        '🚀 [FCM] App dibuka via notifikasi: ${initialMessage.notification?.title}',
      );
      // TODO: navigasi ke halaman tertentu berdasarkan initialMessage.data jika perlu
    }

    // Saat app background (bukan terminated) dan user tap notifikasi
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
        '🔔 [FCM] Notif di-tap dari background: ${message.notification?.title}',
      );
      // TODO: navigasi ke halaman tertentu berdasarkan message.data jika perlu
    });
  }
}
