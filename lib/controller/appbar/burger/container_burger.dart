import 'package:flutter/material.dart';

class ContainerBurger extends StatelessWidget {
  final String texline;
  final VoidCallback onTap; // Parameter untuk fungsi onTap

  ContainerBurger({required this.texline, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Menjalankan fungsi saat menu ditekan
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: 357,
            height: 37,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                texline,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
