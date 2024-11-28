import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/appbar/lokasi.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/controller/level.dart';
import 'package:mea/controller/list/listlaporan.dart';
import 'package:mea/view/all/laporan_aktivitas.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/view/all/pesan.dart';
import 'package:mea/view/all/profile.dart';
import 'package:mea/view/all/tambahlaporan.dart'; // Import halaman TambahLaporan
import 'package:mea/view/floating.dart';

class dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 56),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      burger(),
                      lokasisaatini(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 80.0),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Level(level: 1),
                            SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 123,
                                    height: 69,
                                    child: Text(
                                      "Laporan\nAktivitas\nVolcanic",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        height: 1.0,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    height: 34,
                                    width: 84,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => LaporanAktivitas());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Detail"),
                                          Icon(Icons.arrow_right_sharp,
                                              size: 30),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            listlaporan(),
                            SizedBox(height: 10),
                            listlaporan(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // FloatingNavbar dengan navigasi ke TambahLaporan
            FloatingNavbar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    Get.to(() => dashboard());
                    break;
                  case 1:
                    Get.to(() => TambahLaporan());
                    break;
                  case 2:
                    Get.to(() => Pesan());
                    break;
case 3:
  final authController = Get.find<AuthController>();
  if (authController.isLoggedIn.value) {
    // Jika sudah login, navigasi ke halaman profil
    Get.to(() => ProfilePage(userData: authController.userData.value));
  } else {
    // Jika belum login, navigasi ke halaman login
    Get.to(() => Login());
  }
  break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
