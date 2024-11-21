import 'package:flutter/material.dart';
import 'package:mea/controller/arsip/dropdown.dart';
import 'package:mea/controller/pesan/pesan_kosong.dart';
import 'package:mea/view/all/container_msg.dart';

class Pesan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 56),
Container(
  padding: EdgeInsets.symmetric(horizontal: 16), // Memberi jarak horizontal
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribusi elemen
    crossAxisAlignment: CrossAxisAlignment.center, // Menyelaraskan vertikal
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context); // Navigasi kembali
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
            "Pesan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      SizedBox(width: 27), // Spacer untuk menjaga layout seimbang
    ],
  ),
),

              SizedBox(height: 10),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownBulan(),
                            SizedBox(width: 10),
                            DropdownTahun(),
                          ],
                        ),
                        PesanKosong(isipesan: true),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}