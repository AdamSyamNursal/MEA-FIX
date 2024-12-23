import 'package:flutter/material.dart';
import 'package:mea/controller/list/sub/isilistshort.dart';
import 'package:mea/controller/list/sub/isilistvalid.dart';
import 'package:mea/controller/list/sub/stacklaporan.dart';

class listlaporan extends StatelessWidget {
  final List<Map<String, dynamic>> laporanList;
  final bool acc;
  final String akses;

  listlaporan({required this.laporanList, required this.acc, required this.akses});

  Widget _buildLaporanItem(Map<String, dynamic> laporan) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Menghindari overflow dengan ukuran minimal
          children: [
            Expanded(
              child: gambarstack(
                gambar: laporan['imageUrl'],
                role: laporan['role'] ?? '',
                acc: acc,
                kecamatan: laporan['kecamatan'],
                kelurahan: laporan['kelurahan'],
                time: laporan['tanggal'],
                laporanId: laporan['id'],
                akses: akses,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded( // Membatasi ukuran teks agar tidak overflow
                    child: isilistshor(
                      content: laporan['keterangan'] ?? 'Tidak ada keterangan',
                    ),
                  ),
                  SizedBox(width: 8), // Memberi jarak antara elemen
                  Isilistvalid(
                    valid: laporan['valid'] ?? false,
                    idLaporan: laporan['id'] ?? '',
                    akses: akses,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (laporanList.isEmpty) {
      return Center(
        child: Text(
          'Belum ada laporan.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(// Tambahkan padding untuk ruang ekstra
      itemCount: laporanList.length,
      itemBuilder: (context, index) {
        final laporan = laporanList[index];
        return _buildLaporanItem(laporan);
      },
    );
  }
}
