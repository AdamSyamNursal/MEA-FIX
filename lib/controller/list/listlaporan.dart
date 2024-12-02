import 'package:flutter/material.dart';
import 'package:mea/controller/list/sub/isilistshort.dart';
import 'package:mea/controller/list/sub/isilistvalid.dart';
import 'package:mea/controller/list/sub/stacklaporan.dart';

class listlaporan extends StatelessWidget {
  final List<Map<String, dynamic>> laporanList;

  listlaporan({required this.laporanList});

  Widget _buildLaporanItem(Map<String, dynamic> laporan) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding setiap item
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
          children: [
            // Gambar stack
            gambarstack(),
            // Informasi dan validasi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isilistshor(content: laporan['keterangan'] ?? 'Tidak ada keterangan'),
                  Isilistvalid(
                    valid: laporan['valid'] ?? false,
                    idLaporan: laporan['id'] ?? '',
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

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 70.0), // Tambahkan padding untuk ruang ekstra
      itemCount: laporanList.length,
      itemBuilder: (context, index) {
        final laporan = laporanList[index];
        return _buildLaporanItem(laporan);
      },
    );
  }
}
