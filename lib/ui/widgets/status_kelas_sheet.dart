import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import '../../../models/jadwal.dart';
import '../../../models/jadwal_exception.dart';
import '../../../services/isar_service.dart';
import '../../../services/notification_service.dart';

class StatusKelasSheet extends StatefulWidget {
  final JadwalKuliah jadwal;
  final DateTime tanggal;
  final IsarService isarService;

  const StatusKelasSheet({
    super.key,
    required this.jadwal,
    required this.tanggal,
    required this.isarService,
  });

  @override
  State<StatusKelasSheet> createState() => _StatusKelasSheetState();
}

class _StatusKelasSheetState extends State<StatusKelasSheet> {
  String _statusTerpilih = 'offline'; // Default: offline, online, libur
  final TextEditingController _keteranganController = TextEditingController();
  JadwalException? _exceptionLama;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _muatStatusSaatIni();
  }

  // Cek apakah di tanggal ini udah pernah diset Online/Libur sebelumnya
  Future<void> _muatStatusSaatIni() async {
    final exception = await widget.isarService.cekPengecualian(widget.jadwal.id, widget.tanggal);
    if (exception != null) {
      setState(() {
        _exceptionLama = exception;
        _statusTerpilih = exception.status ?? 'offline';
        _keteranganController.text = exception.keterangan ?? '';
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _simpanStatus() async {
    if (_statusTerpilih == 'offline') {
      // Kalau balik ke offline, hapus exception dari database
      if (_exceptionLama != null) {
        await widget.isarService.hapusPengecualian(_exceptionLama!.id);
      }
      // Kembalikan alarm rutin ke jadwal normal (mulai hari ini/terdekat)
      await notificationService.jadwalkanPengingat(
        id: widget.jadwal.id,
        namaMatkul: widget.jadwal.namaMatkul ?? 'Matkul',
        ruangan: widget.jadwal.ruangan ?? 'Ruangan',
        hari: widget.jadwal.hari ?? 'Senin',
        jamMulai: widget.jadwal.jamMulai ?? '00:00',
      );
    } else {
      // Kalau Online atau Libur, simpan ke database
      final exceptionBaru = JadwalException()
        ..id = _exceptionLama?.id ?? Isar.autoIncrement
        ..jadwalId = widget.jadwal.id
        ..tanggal = DateTime(widget.tanggal.year, widget.tanggal.month, widget.tanggal.day)
        ..status = _statusTerpilih
        ..keterangan = _keteranganController.text;

      await widget.isarService.simpanPengecualian(exceptionBaru);

      // --- PANGGIL ROBOT SATPAM PENGECUALIAN ---
      await notificationService.aturAlarmPengecualian(
        id: widget.jadwal.id,
        namaMatkul: widget.jadwal.namaMatkul ?? 'Matkul',
        ruangan: widget.jadwal.ruangan ?? '-',
        hari: widget.jadwal.hari ?? 'Senin',
        jamMulai: widget.jadwal.jamMulai ?? '00:00',
        status: _statusTerpilih,
        keterangan: _keteranganController.text,
        tanggalTarget: widget.tanggal,
      );
    }

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
    }

    final String tanggalFormat = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(widget.tanggal);

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24, // Biar nggak ketutup keyboard
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ubah Status Kelas',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.jadwal.namaMatkul} • $tanggalFormat',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          // Pilihan Offline (Normal)
          RadioListTile<String>(
            title: const Text('🟢 Berjalan Normal (Offline)', style: TextStyle(fontWeight: FontWeight.w500)),
            value: 'offline',
            groupValue: _statusTerpilih,
            contentPadding: EdgeInsets.zero,
            onChanged: (val) => setState(() => _statusTerpilih = val!),
          ),

          // Pilihan Online
          RadioListTile<String>(
            title: const Text('🟡 Pindah Online', style: TextStyle(fontWeight: FontWeight.w500)),
            value: 'online',
            groupValue: _statusTerpilih,
            contentPadding: EdgeInsets.zero,
            onChanged: (val) => setState(() => _statusTerpilih = val!),
          ),

          if (_statusTerpilih == 'online')
            Padding(
              padding: const EdgeInsets.only(left: 48, bottom: 16),
              child: TextField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Link Zoom / Gmeet',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

          // Pilihan Libur
          RadioListTile<String>(
            title: const Text('🔴 Dosen Batal Masuk (Libur)', style: TextStyle(fontWeight: FontWeight.w500)),
            value: 'libur',
            groupValue: _statusTerpilih,
            contentPadding: EdgeInsets.zero,
            onChanged: (val) => setState(() => _statusTerpilih = val!),
          ),

          if (_statusTerpilih == 'libur')
            Padding(
              padding: const EdgeInsets.only(left: 48, bottom: 16),
              child: TextField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  hintText: 'Keterangan (Opsional)',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

          const SizedBox(height: 24),

          // Tombol Simpan
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _simpanStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}