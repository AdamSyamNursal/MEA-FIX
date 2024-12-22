import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/detail.dart';

class Isilistvalid extends StatelessWidget {
  final bool valid;
  final String idLaporan;
  final String akses;

  Isilistvalid({required this.valid, required this.idLaporan, required this.akses});

  Color backgroundColor() {
    return valid
        ? Color.fromARGB(255, 21, 255, 0) // Hijau terang
        : Color.fromARGB(255, 202, 13, 0); // Merah terang
  }

  String textvalid() {
    return valid ? "Terverifikasi" : "Belum\nTerverifikasi";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => Detail(idLaporan: idLaporan, akses: akses));
      },
      borderRadius: BorderRadius.circular(10), // Menyesuaikan radius untuk efek sentuh
      splashColor: Colors.blue.withOpacity(0.2), // Efek splash saat ditekan
      highlightColor: Colors.blue.withOpacity(0.1), // Warna highlight saat ditekan
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        constraints: BoxConstraints(minHeight: 60), // Menambahkan batas minimum tinggi
        width: 140, // Memperluas lebar kontainer
        decoration: BoxDecoration(
          color: backgroundColor(),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                Text(
                  textvalid(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Menyesuaikan ukuran font
                  color: Colors.white,
                  height: 1.4, // Menambah jarak antar baris teks
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.touch_app, size: 16, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
