import 'package:flutter/material.dart';

class ContainerMsg extends StatelessWidget {
  final String namaPengirim;
  final String deskripsiPesan;
  final String iconPath;
  final Function onTapDetail;

  ContainerMsg({
    required this.namaPengirim,
    required this.deskripsiPesan,
    required this.iconPath,
    required this.onTapDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 130,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Warna bayangan dengan transparansi
            spreadRadius: 5, // Penyebaran bayangan
            blurRadius: 10, // Keburaman bayangan
            offset: Offset(0, 4), // Posisi bayangan (x, y)
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Image.asset(
                  iconPath, // Path ikon dinamis
                  height: 30, // Pastikan ukuran sesuai
                  width: 30,
                ),
                SizedBox(width: 10),
                Text(
                  namaPengirim, // Nama pengirim dari parameter
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              deskripsiPesan, // Deskripsi pesan dari parameter
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => onTapDetail(), // Fungsi detail dari parameter
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Detail",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
