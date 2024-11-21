import 'package:flutter/material.dart';

class deskripsilokasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.all(10), // Padding di luar
            decoration: BoxDecoration(
              color: Colors.white, // Warna latar belakang
              border: Border.all(color: Colors.yellow, width: 2), // Stroke berwarna biru
              borderRadius: BorderRadius.circular(10), // Sudut bulat
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Dikirim Oleh: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "Asep\n\n"),
                  TextSpan(
                    text: "Alamat: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "Simabur\n\n"),
                  TextSpan(
                    text: "Keterangan: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam aliquet, massa novn vehicula elementum, nisi turpis pulvinar.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
