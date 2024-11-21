import 'package:flutter/material.dart';

class FloatingNavbar extends StatelessWidget {
  final Function(int) onTap;

  FloatingNavbar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => onTap(0), // Aksi untuk Home
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () => onTap(1), // Aksi untuk Tambah
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () => onTap(2), // Aksi untuk Pesan
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => onTap(3), // Aksi untuk Profile
            ),
          ],
        ),
      ),
    );
  }
}
