import 'package:flutter/material.dart';

class Level extends StatelessWidget {
  final int level;

  const Level({Key? key, required this.level}) : super(key: key);

  // Warna latar belakang berdasarkan level
  Color getBackground() {
    switch (level) {
      case 4:
        return const Color(0xFFCA0E00); // Merah
      case 3:
        return const Color(0xFFFF6F00); // Oranye
      case 2:
        return const Color(0xFFE6A600); // Kuning
      case 1:
        return const Color(0xFF03A9F4); // Biru
      default:
        return const Color(0xFFFFFFFF); // Putih
    }
  }

  // Deskripsi level
  String getLevelDescription() {
    switch (level) {
      case 4:
        return "Level IV - AWAS\n(Gunung Marapi)";
      case 3:
        return "Level III - SIAGA\n(Gunung Marapi)";
      case 2:
        return "Level II - WASPADA\n(Gunung Marapi)";
      case 1:
        return "Level I - NORMAL\n(Gunung Marapi)";
      default:
        return "error";
    }
  }

  // Ikon berdasarkan level
  String getIconPath() {
    switch (level) {
      case 4:
        return 'assets/icons/logo4.png';
      case 3:
        return 'assets/icons/logo3.png';
      case 2:
        return 'assets/icons/logo2.png';
      case 1:
        return "assets/icons/logo1.png";
      default:
        return 'assets/icons/error.png';
    }
  }

  // Deskripsi tambahan berdasarkan level
  String getAdditionalDescription() {
    switch (level) {
      case 4:
        return "Ancaman bahaya besar. Segera ikuti arahan evakuasi!";
      case 3:
        return "Tingkatkan kewaspadaan dan persiapkan diri untuk evakuasi.";
      case 2:
        return "Pantau informasi terbaru dari otoritas terkait.";
      case 1:
        return "Kondisi normal. Tetap waspada.";
      default:
        return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: getBackground(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Level Title
          Text(
            getLevelDescription(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          // Icon
          SizedBox(
            height: 70,
            width: 70,
            child: Image.asset(getIconPath()),
          ),
          const SizedBox(height: 10),
          // Additional Description
          Text(
            getAdditionalDescription(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class LevelScreen extends StatelessWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Level Status"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Level(level: 4),
            Level(level: 3),
            Level(level: 2),
            Level(level: 1),
          ],
        ),
      ),
    );
  }
}
