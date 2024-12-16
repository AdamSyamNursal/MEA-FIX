import 'package:flutter/material.dart';

class Kosong extends StatelessWidget {
  final bool isilist;
  final Widget content;

  Kosong({required this.isilist, required this.content});

  @override
  Widget build(BuildContext context) {
    return isilist
        ? content // Tampilkan konten jika ada data
        : Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Arsip Kosong",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6F00),
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/kosong.png',
                  width: 250,
                  height: 294,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          );
  }
}
