import 'package:flutter/material.dart';
import 'package:mea/view/all/detailpesan.dart'; // Import halaman DetailPesan

class ContainerMsg extends StatelessWidget {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Image.asset("assets/icons/relawan.png"),
                SizedBox(width: 10),
                Text(
                  "Junaidi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            width: double.infinity,
            height: 64,
            child: Center(
              child: Text(
                "Cuaca berawan. Angin bertiup lemah ke arah timur dan barat laut. Suhu udara 21.1-28.3 °C, kelembaban udara 60.5-84.3 %, dan tekanan udara 681.8-681.9 mmHg",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 22,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailpesan(), // Navigasi ke DetailPesan
                  ),
                );
              },
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
                  SizedBox(width: 10),
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
