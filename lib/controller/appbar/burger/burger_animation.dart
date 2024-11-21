import 'package:flutter/material.dart';
import 'package:mea/controller/appbar/burger/container_burger.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback onClose;

  Sidebar({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 412,
        height: 330,
        padding: EdgeInsets.only(top: 56), // Sesuaikan jarak dari atas
        color: Color(0xFFFF6F00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            ContainerBurger(
              texline: "Tentang Aplikasi",
              onTap: () async {
                onClose(); // Menutup sidebar
                await Future.delayed(Duration(milliseconds: 300)); // Tunggu animasi selesai
                Navigator.pushNamed(context, '/tentangaplikasi');
              },
            ),
            ContainerBurger(
              texline: "Kontak BPBD",
              onTap: () async {
                onClose();
                await Future.delayed(Duration(milliseconds: 300));
                Navigator.pushNamed(context, '/hubungi');
              },
            ),
            ContainerBurger(
              texline: "Arsip",
              onTap: () async {
                onClose();
                await Future.delayed(Duration(milliseconds: 300));
                Navigator.pushNamed(context, '/arsip');
              },
            ),
            SizedBox(height: 10),
            Container(
              height: 84,
              width: 84,
              child: Center(
                child: Image.asset("assets/images/BPBD.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
