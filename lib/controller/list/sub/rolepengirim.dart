import 'package:flutter/material.dart';

class rolepengirim extends StatelessWidget {
  final String role;

  rolepengirim({required this.role});

  Map<String, dynamic> tampilanrole() {
    if (role == "Relawan") {
      return {
        "gambar": "assets/icons/relawan.png",
        "tulisan": Text(
          role,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      };
    } else if (role == "BPBD") {
      return {
        "gambar": "assets/icons/bpbd.png",
        "tulisan": Text(
          role,
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
      };
    } else {
      return {
        "gambar": "assets/icons/masyarakat.png",
        "tulisan": Text(
          "User",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleData = tampilanrole();
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 100,
          height: 23,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                roleData["gambar"], // Mengakses gambar dari fungsi
                height: 16, // Pastikan gambar memiliki ukuran yang sesuai
              ),
              SizedBox(width: 5), // Memberikan jarak antara gambar dan teks
              roleData["tulisan"], // Mengakses tulisan dari fungsi
            ],
          ),
        ),
      ),
    );
  }
}
