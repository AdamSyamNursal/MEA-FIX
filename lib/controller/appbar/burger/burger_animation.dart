import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/appbar/burger/container_burger.dart';
import 'package:mea/view/all/arsip.dart';
import 'package:mea/view/all/hubungi.dart';
import 'package:mea/view/all/tentangaplikasi.dart';

class Sidebar extends StatelessWidget {
  final VoidCallback onClose;

  const Sidebar({super.key, required this.onClose}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 412,
        height: 330,
        padding: const EdgeInsets.only(top: 56), 
        color: const Color(0xFFFF6F00), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30), 
            ContainerBurger(
              texline: "Tentang Aplikasi",
              onTap: () async {
                onClose(); // Menutup sidebar
                await Future.delayed(const Duration(milliseconds: 300)); 
                Get.to(() => Tentangaplikasi()); 
              },
            ),
            ContainerBurger(
              texline: "Kontak BPBD",
              onTap: () async {
                onClose();
                await Future.delayed(const Duration(milliseconds: 300)); 
                Get.to(() => Hubungi());
              },
            ),
            ContainerBurger(
              texline: "Arsip",
              onTap: () async {
                onClose();
                await Future.delayed(const Duration(milliseconds: 300)); 
                Get.to(() => Arsip());
              },
            ),
            const SizedBox(height: 10), 
            SizedBox(
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
