import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/editlaporanaktivitas.dart';

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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('detailLaporan')
                      .orderBy('timestamp', descending: true)
                      .limit(1)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "Belum ada data laporan.",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      );
                    }

                    final laporanList = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return data;
                    }).toList();

                    return ListView.builder(
                      itemCount: laporanList.length,
                      itemBuilder: (context, index) {
                        final laporan = laporanList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Periode Pengamatan",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      if (role == "BPBD" && acc)
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => EditLaporanAktivitas());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF6F00),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "${laporan['tanggal'] ?? 'N/A'}",
                                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                  ),
                                  Text(
                                    "${laporan['jam'] ?? 'N/A'} WIB",
                                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                  ),
                                  SizedBox(height: 20),
                                  KolumLaporan(judul: "Meteorologist", deskripsi: laporan['meteorologist'] ?? "N/A"),
                                  SizedBox(height: 10),
                                  KolumLaporan(judul: "Visual", deskripsi: laporan['visual'] ?? "N/A"),
                                  SizedBox(height: 10),
                                  KolumLaporan(judul: "Kegempaan", deskripsi: laporan['kegempaan'] ?? "N/A"),
                                  SizedBox(height: 10),
                                  KolumLaporan(judul: "Keterangan", deskripsi: laporan['keterangan'] ?? "N/A"),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
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
