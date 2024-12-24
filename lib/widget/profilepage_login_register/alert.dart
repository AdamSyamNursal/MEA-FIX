import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/login.dart'; // Pastikan jalur file login benar

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Alert
              Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/icons/logo3.png', // Pastikan file logo berada di lokasi ini
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              // Teks Pemberitahuan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Mohon Bersabar!\nAnda menunggu konfirmasi dari BPBD dalam waktu 1 x 48 jam",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Informasi Kontak
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Hubungi BPBD Tanah Datar atau hubungi di Instagram @bpbd_tanah_datar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Tombol Next
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Login()); // Navigasi ke halaman login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Color(0xFFFF6F00),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
