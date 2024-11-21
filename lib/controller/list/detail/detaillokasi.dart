import 'package:flutter/material.dart';

class detaillokasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.all(10), // Padding di luar
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        border: Border.all(color: Colors.blue, width: 2), // Stroke berwarna biru
        borderRadius: BorderRadius.circular(10), // Sudut bulat
      ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Nama Jalan: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "Jl. Merpati No. 45\n"),
                  TextSpan(
                    text: "Kelurahan: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "Kampung Baru\n"),
                  TextSpan(
                    text: "Kecamatan: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "Padang Barat\n"),
                  TextSpan(
                    text: "Kota: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "Padang\n"),
                  TextSpan(
                    text: "Provinsi: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "Sumatera Barat\n"),
                  TextSpan(
                    text: "Kode Pos: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "25112"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
