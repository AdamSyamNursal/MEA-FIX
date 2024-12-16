import 'package:flutter/material.dart';

class Level extends StatelessWidget {
  final int level;

  const Level({Key? key, required this.level}) : super(key: key); // Menambahkan 'const' dan parameter 'key'

  Color getBackground() {
    switch (level) {
      case 4:
        return const Color(0xFFCA0E00);
      case 3:
        return const Color(0xFFFF6F00);
      case 2:
        return const Color(0xFFFFD700);
      case 1:
        return const Color(0xFF03A9F4);
      default:
        return const Color(0xFFFFFFFF);
    }
  }

  String getLevelDescription() {
    switch (level) {
      case 4:
        return "Level IV";
      case 3:
        return "Level III";
      case 2:
        return "Level II";
      case 1:
        return "Level I";
      default:
        return "error";
    }
  }

  String getLevelAlert() {
    switch (level) {
      case 4:
        return "AWAS";
      case 3:
        return "SIAGA";
      case 2:
        return "WASPADA";
      case 1:
        return "NORMAL";
      default:
        return "error";
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      width: 365,
      decoration: BoxDecoration(
        color: getBackground(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 3,
                child: Container(
                  width: 100, // Adjust to match text width
                  height: 3, // Thickness of the underline
                  color: Colors.white, // Color of the underline
                ),
              ),
              Text(
                getLevelDescription(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getLevelAlert(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                const SizedBox(width: 5), // Mengganti padding dengan SizedBox
                SizedBox(
                  height: 60,
                  width: 70,
                  child: Image.asset(getIconPath()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
