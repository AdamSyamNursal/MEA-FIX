import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/dashboar.dart'; // Pastikan ini mengarah ke halaman dashboard

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: GestureDetector(
          onTap: () {
            // Navigasi ke halaman dashboard menggunakan GetX
            Get.to(() => dashboard());
          },
          child: Center(
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
      ),
    );
  }
}
