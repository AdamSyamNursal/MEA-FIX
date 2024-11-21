import 'package:flutter/material.dart';

class Detailpesan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            // Header dengan Tombol Back dan Teks
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Navigasi kembali
                    },
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 10), // Spasi antara ikon dan teks
                  Text(
                    "Detail Pesan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Isi Halaman
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      // Tanggal
                      Center(
                        child: Text(
                          "14-11-2024",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Pesan Pertama
                      _buildPesanContainer(
                        context,
                        iconPath: "assets/icons/relawan.png",
                        nama: "Junaidi",
                        warnaNama: Colors.green,
                        isiPesan:
                            "Cuaca berawan. Angin bertiup lemah ke arah timur dan barat laut. Suhu udara 21.1-28.3 °C, kelembaban udara 60.5-84.3 %, dan tekanan udara 681.8-681.9 mmHg",
                      ),
                      SizedBox(height: 10),
                      // Pesan Kedua
                      _buildPesanContainer(
                        context,
                        iconPath: "assets/icons/BPBDicon.png",
                        nama: "Supriadi",
                        warnaNama: Colors.orange,
                        isiPesan:
                            "Cuaca berawan. Angin bertiup lemah ke arah timur dan barat laut. Suhu udara 21.1-28.3 °C, kelembaban udara 60.5-84.3 %, dan tekanan udara 681.8-681.9 mmHg",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat widget container pesan
  Widget _buildPesanContainer(
    BuildContext context, {
    required String iconPath,
    required String nama,
    required Color warnaNama,
    required String isiPesan,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16), // Margin horizontal
      padding: EdgeInsets.all(16), // Padding dalam kontainer
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Warna bayangan
            blurRadius: 10, // Radius bayangan
            offset: Offset(0, 4), // Posisi bayangan
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama dan Ikon
          Row(
            children: [
              Image.asset(iconPath, height: 24, width: 24), // Ikon pengirim
              SizedBox(width: 10),
              Text(
                nama,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: warnaNama,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Isi Pesan
          Text(
            isiPesan,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis, // Pemangkasan teks panjang
          ),
        ],
      ),
    );
  }
}
