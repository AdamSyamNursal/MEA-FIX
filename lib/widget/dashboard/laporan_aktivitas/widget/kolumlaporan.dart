import 'package:flutter/material.dart';

class KolumLaporan extends StatelessWidget {
  final String judul;
  final String deskripsi;

  KolumLaporan({required this.judul, required this.deskripsi});

  IconData getIconForJudul(String judul) {
    switch (judul) {
      case "Meteorologist":
        return Icons.cloud;
      case "Visual":
        return Icons.visibility;
      case "Kegempaan":
        return Icons.vibration;
      case "Keterangan":
        return Icons.info;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          getIconForJudul(judul),
          size: 30,
          color: Color(0xFFFF6F00),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(deskripsi),
            ],
          ),
        ),
      ],
    );
  }
}