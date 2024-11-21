import 'package:flutter/material.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
