import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/editlaporanaktivitas.dart';

class LaporanAktivitas extends StatelessWidget {
  final String role;

  LaporanAktivitas({required this.role});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            SizedBox(height: 56),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => dashboard()); // Kembali ke halaman sebelumnya
                    },
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Laporan Aktivitas",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('detailLaporan')
                      .orderBy('timestamp', descending: true) // Urutkan berdasarkan timestamp terbaru
                      .limit(1) // Hanya ambil 1 dokumen terbaru
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("Belum ada data laporan."),
                      );
                    }

                    // Data detail laporan
                    final laporanList = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return data;
                    }).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.all(20.0),
                      itemCount: laporanList.length,
                      itemBuilder: (context, index) {
                        final laporan = laporanList[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Periode Pengamatan",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                // Tombol Edit
                                role == "BPBD"
    ? GestureDetector(
        onTap: () {
          Get.to(() => EditLaporanAktivitas());
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      )
    : SizedBox.shrink(), // Tidak menampilkan apa-apa jika kondisi tidak terpenuhi

                              ],
                            ),
                            SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${laporan['tanggal'] ?? 'N/A'}",
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                ),
                                Text("${laporan['jam'] ?? 'N/A'} WIB",
                                style: TextStyle(fontSize: 16, color: Colors.grey[700]),),
                              ],
                            ),
                            SizedBox(height: 20),
                            KolumLaporan(judul: "Meteorologist", deskripsi: laporan['meteorologist'] ?? "N/A"),
                            SizedBox(height: 10),
                            KolumLaporan(judul: "Visual", deskripsi: laporan['visual'] ?? "N/A"),
                            SizedBox(height: 10),
                            KolumLaporan(judul: "Kegempaan", deskripsi: laporan['kegempaan'] ?? "N/A"),
                            SizedBox(height: 10),
                            KolumLaporan(judul: "Keterangan", deskripsi: laporan['keterangan'] ?? "N/A"),
                            SizedBox(height: 20),
                            Divider(color: Colors.grey), // Pembatas antar laporan
                          ],
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

  // Fungsi untuk mendapatkan ikon berdasarkan judul
  String getIconForJudul(String judul) {
    switch (judul) {
      case "Meteorologist":
        return "assets/icons/meterologi.png";
      case "Visual":
        return "assets/icons/eye.png";
      case "Kegempaan":
        return "assets/icons/frekuensi.png";
      case "Keterangan":
        return "assets/icons/eye.png"; // Gunakan ikon default untuk Keterangan
      default:
        return "assets/icons/placeholder.png"; // Ikon default jika judul tidak dikenal
    }
  }

  @override
  Widget build(BuildContext context) {
    final String iconPath = getIconForJudul(judul); // Dapatkan ikon berdasarkan judul

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 10, // Spread of the shadow
            offset: Offset(0, 4), // Position of the shadow (horizontal, vertical)
          ),
        ],
      ),
      child: Row(
        children: [
          // Menampilkan ikon berdasarkan judul
          Container(
            height: 50,
            width: 50,
            child: Image.asset(iconPath, fit: BoxFit.cover),
          ),
          SizedBox(width: 10), // Space between the icon and text
          // Menampilkan deskripsi berdasarkan parameter
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
      ),
    );
  }
}
