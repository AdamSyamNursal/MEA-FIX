import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/detail/maps.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/detail/detaillokasi.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/detail/deskripsiinformasi.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/detail/validdetail.dart';

class Detail extends StatelessWidget {
  final String idLaporan;
  final String akses;

  Detail({required this.idLaporan, required this.akses});

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
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullScreenImage(
                                        imageUrl: data['imageUrl'] ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 200, // Ukuran gambar diperkecil
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(data['imageUrl'] ?? ''),
                                      fit: BoxFit.cover, // Sesuaikan untuk memastikan gambar terlihat proporsional
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 30,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Gambar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          maps(
                            latitude: data['latitude'] ?? 0.0,
                            longtitude: data['longtitude'] ?? 0.0,
                          ),
                          SizedBox(height: 5),
                          detaillokasi(
                            id: data['id'] ?? 'Alamat tidak tersedia',
                          ),
                          SizedBox(height: 20),
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

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
