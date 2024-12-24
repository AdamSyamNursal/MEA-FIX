import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/editlaporanaktivitas.dart';
import 'package:mea/widget/dashboard/laporan_aktivitas/laporan_aktivitas.dart';

class CLaporanAktivitas extends StatelessWidget {
  final String role;
  final bool acc;

  CLaporanAktivitas({required this.role, required this.acc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                );
  }
}