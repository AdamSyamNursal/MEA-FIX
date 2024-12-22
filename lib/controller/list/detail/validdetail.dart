import 'package:flutter/material.dart';

class Validdetail extends StatelessWidget {
  final bool valid;

  Validdetail({required this.valid});

  Color kotakvalid() {
    if (valid == true) {
      return Colors.green.shade600; // Warna hijau yang lebih cerah
    } else {
      return Colors.red.shade600; // Warna merah yang lebih cerah
    }
  }

  String deskValid() {
    if (valid == true) {
      return "Terverifikasi";
    } else {
      return "Belum Terverifikasi";
    }
  }

  IconData iconValid() {
    if (valid == true) {
      return Icons.check_circle; // Ikon centang untuk valid
    } else {
      return Icons.cancel; // Ikon silang untuk tidak valid
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 60,
      decoration: BoxDecoration(
        color: kotakvalid(),
        borderRadius: BorderRadius.circular(20), // Radius untuk sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3), // Efek bayangan
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconValid(),
            color: Colors.white,
            size: 30, // Ukuran ikon
          ),
          SizedBox(width: 10),
          Text(
            deskValid(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18, // Ukuran teks lebih besar untuk kejelasan
            ),
          ),
        ],
      ),
    );
  }
}
