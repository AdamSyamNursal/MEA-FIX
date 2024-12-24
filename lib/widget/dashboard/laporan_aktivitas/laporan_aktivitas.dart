import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/widget/dashboard/laporan_aktivitas/controller/c_laporan_aktivitas.dart';

class LaporanAktivitas extends StatelessWidget {
  final String role;
  final bool acc;

  LaporanAktivitas({required this.role, required this.acc});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFFFF6F00),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => dashboard());
                    },
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  Text(
                    "Laporan Aktivitas",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(width: 24), // Placeholder untuk menjaga keseimbangan layout
                ],
              ),
            ),
            SizedBox(height: 10),
            // Konten
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CLaporanAktivitas(role: role, acc: acc)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KolumLaporan extends StatelessWidget {
  final String judul;
  final String deskripsi;

  KolumLaporan({required this.judul, required this.deskripsi});

  IconData getIconForJudul(String judul) {
    switch (judul) {
      case "Meteorologist":
        return Icons.cloud;
      case "Visual":
        return Icons.visibility;
      case "Kegempaan":
        return Icons.vibration;
      case "Keterangan":
        return Icons.info;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          getIconForJudul(judul),
          size: 30,
          color: Color(0xFFFF6F00),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(deskripsi),
            ],
          ),
        ),
      ],
    );
  }
}
