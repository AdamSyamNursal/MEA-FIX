import 'package:flutter/material.dart';
import 'package:mea/controller/rekomendasi/rekomendasi_text.dart';


class Rekomendasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 56),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.arrow_back_rounded, color: Colors.white),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Rekomendasi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
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
                        Align(
                          alignment: Alignment.center,  // Menempatkan tanggal di tengah
                          child: Text(
                            "14-11-2024",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,  // Menempatkan gambar di tengah
                          child: Image.asset("assets/images/BPBD.png", height: 80, width: 80),
                        ),
                        SizedBox(height: 20),
                        RekomendasiText(),  // Menggunakan widget RekomendasiText yang telah dipisahkan
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
