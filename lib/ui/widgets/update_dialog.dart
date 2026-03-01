import 'package:flutter/material.dart';

import '../../services/update_service.dart';

import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatefulWidget {
  final UpdateInfo info;

  const UpdateDialog({super.key, required this.info});

  /// Tampilkan dialog update. Panggil ini dari initState halaman utama.
  static Future<void> showIfNeeded(BuildContext context) async {
    final info = await UpdateService.checkUpdate();
    if (info == null) return;
    if (!context.mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: !info.forceUpdate,
      builder: (_) => UpdateDialog(info: info),
    );
  }

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  bool _isLaunching = false;

  Future<void> _startDownload() async {
    setState(() {
      _isLaunching = true;
    });

    try {
      final Uri url = Uri.parse(widget.info.downloadUrl);

      // Buka link GDrive/Apk di browser eksternal
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal membuka link update.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLaunching = false;
        });
        // Jika force update, jangan tutup dialognya
        if (!widget.info.forceUpdate) Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: !widget.info.forceUpdate && !_isLaunching,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Icons.system_update_rounded,
              color: theme.colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 10),
            Text(
              'Update Tersedia!',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge versi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Versi ${widget.info.latestVersionName}',
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Catatan update
            Text(
              'Yang baru:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.info.releaseNotes,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),

            if (widget.info.forceUpdate && !_isLaunching)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange.shade700,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Update ini wajib dipasang untuk melanjutkan.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        actions: [
          if (!widget.info.forceUpdate && !_isLaunching)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Nanti'),
            ),
          FilledButton.icon(
            onPressed: _isLaunching ? null : _startDownload,
            icon: _isLaunching
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.download_rounded),
            label: Text(_isLaunching ? 'Membuka...' : 'Update Sekarang'),
          ),
        ],
      ),
    );
  }
}
