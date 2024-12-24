import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mea/widget/dashboard/level.dart';

import 'package:mea/widget/dashboard/burger/burger.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/widget/dashboard/laporan_aktivitas/laporan_aktivitas.dart';
import 'package:mea/view/navigation_bar.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/laporan_stream.dart';
import 'package:mea/widget/dashboard/level/level_controller.dart';
import 'package:mea/widget/dashboard/level/level_dropdown.dart';
import 'package:mea/widget/dashboard/rekomendasi_button/popupmenubutton.dart';

class dashboard extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final LevelController levelController = Get.put(LevelController());

  void _showEditDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return LevelDropdown(levelController: levelController);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFFF6F00),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Burger(),
              Popupmenubutton(authController: authController)
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
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
                        Obx(() => Level(level: levelController.selectedLevel.value)),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (authController.role == "BPBD" && authController.acc)
                                ElevatedButton(
                                  onPressed: () {
                                    _showEditDropdown(context);
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFF6F00)),
                                ),
                              SizedBox(width: authController.role == "BPBD" && authController.acc ? 10 : 0),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => LaporanAktivitas(role: authController.role, acc: authController.acc));
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF6F00),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Detail",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: ReportListStream(authController: authController),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          authController: Get.find<AuthController>(),
          currentIndex: 0, // Set tab pertama sebagai aktif
        ),
      ),
    );
  }
}