import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/dashboar.dart'; // Pastikan ini mengarah ke halaman dashboard

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigasi otomatis setelah 2 detik
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => dashboard()); // Menggunakan Get.off agar halaman splash tidak dapat kembali
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Center(
          child: Container(
            height: 480,
            width: 480,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
