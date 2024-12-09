import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/controller/list/detail/deskripsiinformasi.dart';
import 'package:mea/controller/list/detail/detaillokasi.dart';
import 'package:mea/controller/list/detail/maps.dart';
import 'package:mea/controller/list/detail/validdetail.dart';
import 'package:mea/controller/list/sub/stacklaporan.dart';

class Detail extends StatelessWidget {
  final String idLaporan; // Tambahkan parameter ID laporan

  Detail({required this.idLaporan});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            // AppBar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 27,
                      width: 27,
                      child: Icon(
                        Icons.keyboard_backspace_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Detail Laporan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 27),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Konten Detail
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('laporan')
                      .doc(idLaporan)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Center(child: Text("Laporan tidak ditemukan."));
                    }

                    final data = snapshot.data!.data() as Map<String, dynamic>;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          gambarstack(
                            role: data['role'] ?? '',
                            acc: data ['acc'] ?? false,
                            gambar: data['imageUrl'] ?? ''
                          ), // Sesuaikan dengan data jika perlu
                          maps(), // Tambahkan logika untuk menampilkan peta berdasarkan data
                          SizedBox(height: 5),
                          detaillokasi(
                            id: data['id'] ?? 'Alamat tidak tersedia',
                          ),
                          SizedBox(height: 5),
                          deskripsilokasi(
                            id: data['id'] ?? 'Deskripsi tidak tersedia',
                          ),
                          SizedBox(height: 10),
                          Validdetail(
                            valid: data['valid'] ?? false,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
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
