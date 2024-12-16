import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/view/all/container_msg.dart';

class PesanKosong extends StatelessWidget {
  final bool isiPesan;

  PesanKosong({required this.isiPesan});

  @override
  Widget build(BuildContext context) {
    if (!isiPesan) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pesan Kosong",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6F00)
            ),
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/images/kosong.png',
            width: 250,
            height: 294,
            fit: BoxFit.fill,
          ),
        ],
      );
    }

    // Menampilkan data dari Firebase
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('pesan')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tidak ada pesan dari Relawan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F00)
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/images/kosong.png',
                width: 250,
                height: 294,
                fit: BoxFit.fill,
              ),
            ],
          );
        }

        final List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final pesan = docs[index].data() as Map<String, dynamic>;

            return ContainerMsg(
              namaPengirim: pesan['namaPengirim'] ?? 'Tidak diketahui',
              deskripsiPesan: pesan['pertanyaan'] ?? 'Pesan tidak ada deskripsi',
              iconPath: 'assets/icons/relawan.png',
              onTapDetail: () {
                // Tambahkan logika untuk navigasi atau aksi lainnya
              },
            );
          },
        );
      },
    );
  }
}
