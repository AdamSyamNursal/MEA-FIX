import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class detaillokasi extends StatelessWidget {
  final String id; // Parameter ID laporan

  detaillokasi({required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('laporan').doc(id).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Text(
              "Detail lokasi tidak ditemukan.",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  "Detail Lokasi:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: 320,
                height: 180,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Nama Jalan: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['nama_jalan'] ?? 'Tidak tersedia'}\n",
                      ),
                      TextSpan(
                        text: "Kelurahan: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['kelurahan'] ?? 'Tidak tersedia'}\n",
                      ),
                      TextSpan(
                        text: "Kecamatan: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['kecamatan'] ?? 'Tidak tersedia'}\n",
                      ),
                      TextSpan(
                        text: "Kota: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['kota'] ?? 'Tidak tersedia'}\n",
                      ),
                      TextSpan(
                        text: "Provinsi: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['provinsi'] ?? 'Tidak tersedia'}\n",
                      ),
                      TextSpan(
                        text: "Kode Pos: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['kode_pos'] ?? 'Tidak tersedia'}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
