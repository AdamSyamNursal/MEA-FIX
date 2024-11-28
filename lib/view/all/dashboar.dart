import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/controller/level.dart';
import 'package:mea/controller/list/kosong.dart';
import 'package:mea/controller/list/listlaporan.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/appbar/lokasi.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/view/all/profile.dart';
import 'package:mea/view/all/tambahlaporan.dart';
import 'package:mea/view/floating.dart';

class dashboard extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  void _showEditDropdown(BuildContext context) {
    // Tambahkan logika untuk dropdown "Edit"
    print("Edit dropdown dipilih");
  }

  void _handleNotificationAction(String value) {
    // Tambahkan logika untuk notifikasi
    print("Notifikasi: $value");
  }

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
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          // Level Indicator
                          Level(level: 1),
                          SizedBox(height: 10),
                          // Tombol Edit, Notifikasi, dan Detail
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _showEditDropdown(context);
                                    },
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  PopupMenuButton<String>(
                                    onSelected: (String value) {
                                      _handleNotificationAction(value);
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: "Laporan",
                                          child: Text("Laporan"),
                                        ),
                                        PopupMenuItem(
                                          value: "Akun",
                                          child: Text("Akun"),
                                        ),
                                      ];
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.notifications, color: Colors.black),
                                        SizedBox(width: 5),
                                        Text(
                                          "Notifikasi",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 34,
                                    width: 84,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Detail"),
                                        Icon(Icons.arrow_right_sharp, size: 30),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Daftar Laporan
                          Container(
                            height: 400,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('laporan')
                                  .orderBy('tanggal', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                            
                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Kosong(
                                    isilist: false,
                                    content: Container(),
                                  );
                                }
                            
                                final laporanList = snapshot.data!.docs.map((doc) {
                                  return doc.data() as Map<String, dynamic>;
                                }).toList();
                            
                                return Kosong(
                                  isilist: true,
                                  content: listlaporan(laporanList: laporanList),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // FloatingNavbar
            FloatingNavbar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    Get.to(() => dashboard());
                    break;
                  case 1:
                    if (authController.isLoggedIn.value) {
                      Get.to(() => TambahLaporan(
                            userId: authController.userId,
                            role: authController.role,
                          ));
                    } else {
                      Get.to(() => TambahLaporan(
                            userId: '',
                            role: 'user',
                          ));
                    }
                    break;
                  case 2:
                    // Navigasi lainnya
                    break;
                  case 3:
                    if (authController.isLoggedIn.value) {
                      Get.to(() => ProfilePage(
                            userData: authController.userData.value,
                          ));
                    } else {
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
