import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateInfo {
  final int latestVersionCode;
  final String latestVersionName;
  final String downloadUrl;
  final String releaseNotes;
  final bool forceUpdate;

  const UpdateInfo({
    required this.latestVersionCode,
    required this.latestVersionName,
    required this.downloadUrl,
    required this.releaseNotes,
    required this.forceUpdate,
  });
}

class UpdateService {
  UpdateService._();

  /// Cek apakah ada update tersedia.
  /// Return [UpdateInfo] jika ada update, null jika sudah versi terbaru.
  static Future<UpdateInfo?> checkUpdate() async {
    try {
      // Ambil versi app saat ini
      final info = await PackageInfo.fromPlatform();
      final currentVersionCode = int.tryParse(info.buildNumber) ?? 0;
      debugPrint('🔄 [OTA] Current version code: $currentVersionCode');

      // Ambil info versi terbaru dari Firestore (HINDARI CACHE LOKAL)
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('app_version')
          .get(const GetOptions(source: Source.server));

      if (!doc.exists) {
        debugPrint(
          '❌ [OTA] Dokumen config/app_version tidak ditemukan di Firestore!',
        );
        return null;
      }

      final data = doc.data()!;

      // Ambil latestVersionCode (handle bentuk angka maupun string dar web admin)
      int latestVersionCode = 0;
      if (data['latestVersionCode'] != null) {
        if (data['latestVersionCode'] is num) {
          latestVersionCode = (data['latestVersionCode'] as num).toInt();
        } else {
          latestVersionCode =
              int.tryParse(data['latestVersionCode'].toString()) ?? 0;
        }
      }

      debugPrint(
        '🚀 [OTA] Latest version code dari Firestore: $latestVersionCode',
      );

      // Ada update kalau latestVersionCode lebih tinggi, ATAU version name-nya beda (sebagai fallback kalau buildNumber nge-bug di lokal)
      final currentVersionName = info.version;
      final latestVersionName = data['latestVersionName']?.toString() ?? '';

      bool isUpdateAvailable = latestVersionCode > currentVersionCode;

      // Fallback: Jika versionCode bilang up-to-date, tapi nama versinya beda dengan Firestore, paksa update.
      if (!isUpdateAvailable &&
          latestVersionName.isNotEmpty &&
          latestVersionName != currentVersionName) {
        debugPrint(
          '⚠️ [OTA] buildNumber up-to-date tapi versionName BEDA ($currentVersionName vs $latestVersionName). Anggap ada update!',
        );
        isUpdateAvailable = true;
      }

      if (!isUpdateAvailable) {
        debugPrint(
          '✅ [OTA] App sudah up-to-date. (Name: $currentVersionName, Code: $currentVersionCode)',
        );
        return null;
      }

      debugPrint(
        '🔥 [OTA] Update tersedia! Versi $latestVersionCode (Buka dialog)',
      );
      return UpdateInfo(
        latestVersionCode: latestVersionCode,
        latestVersionName: data['latestVersionName']?.toString() ?? '',
        downloadUrl: data['downloadUrl']?.toString() ?? '',
        releaseNotes:
            data['releaseNotes']?.toString() ??
            'Ada peningkatan performa dan perbaikan bug.',
        forceUpdate:
            data['forceUpdate'] == true || data['forceUpdate'] == 'true',
      );
    } catch (e) {
      debugPrint('🚨 [OTA] Gagal cek update: $e');
      // Gagal cek update — tidak perlu crash app
      return null;
    }
  }
}
