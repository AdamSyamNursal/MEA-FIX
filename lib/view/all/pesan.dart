import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/arsip/dropdown.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/controller/arsip/PesanFilterController.dart';
import 'package:mea/widget/pesan/controller/controllerpesan.dart';
import 'package:mea/widget/pesan/tambahpesan.dart';
import 'package:mea/view/navigation_bar.dart';

class Pesan extends StatelessWidget {
  final String userId;
  final String role;
  final bool acc;
  final FilterController controller = Get.put(FilterController());

  Pesan({required this.userId, required this.role, required this.acc});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFFF6F00),
          title: Text(
            "Pesan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownBulan(),
                        SizedBox(width: 10),
                        DropdownTahun(),
                      ],
                    ),
                    Expanded(
                      child: Obx(() {
                        final bulan = controller.bulanTerpilih;
                        final tahun = controller.tahunTerpilih;

                        return Controllerpesan(bulan: bulan, tahun: tahun, role: role);
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Tampilkan FAB hanya jika role bukan 'BPBD'
        floatingActionButton: (role != 'BPBD' || acc != true)
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => Tambahpesan(
                        userid: userId,
                        role: role,
                      ));
                },
                backgroundColor: Color(0xFFFF6F00),
                child: Icon(Icons.add, color: Colors.white),
              )
            : null,
        bottomNavigationBar: CustomNavigationBar(
          authController: Get.find<AuthController>(),
          currentIndex: 2, // Tab ke-2 untuk Pesan
        ),
      ),
    );
  }
}
