import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class deskripsilokasi extends StatelessWidget {
  final String id; // Parameter ID laporan

  deskripsilokasi({required this.id});

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
              "Deskripsi tidak ditemukan.",
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
                  "Deskripsi Informasi:",
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
                  border: Border.all(color: Colors.yellow, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Dikirim Oleh: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['pengirim'] ?? 'Tidak tersedia'}\n\n",
                      ),
                      TextSpan(
                        text: "Alamat: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['alamat'] ?? 'Tidak tersedia'}\n\n",
                      ),
                      TextSpan(
                        text: "Keterangan: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${data['keterangan'] ?? 'Tidak tersedia'}",
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
