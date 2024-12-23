import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/controller/level.dart';
import 'package:mea/controller/list/kosong.dart';
import 'package:mea/controller/list/listlaporan.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/akun.dart';
import 'package:mea/view/all/laporan.dart';
import 'package:mea/view/all/laporan_aktivitas.dart';
import 'package:mea/view/all/rekomendasi.dart';
import 'package:mea/view/navigation_bar.dart';

class dashboard extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final LevelController levelController = Get.put(LevelController());

  void _showEditDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pilih Level"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Level 1 (Normal)"),
                onTap: () {
                  levelController.setLevel(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Level 2 (Waspada)"),
                onTap: () {
                  levelController.setLevel(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Level 3 (Siaga)"),
                onTap: () {
                  levelController.setLevel(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Level 4 (Awas)"),
                onTap: () {
                  levelController.setLevel(4);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        appBar: AppBar(
          backgroundColor: Color(0xFFFF6F00),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Burger(),
              PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == "Rekomendasi") {
                    Get.to(() => Rekomendasi(
                          role: authController.role,
                          acc: authController.acc,
                        ));
                  }
                  if (value == "Laporan") {
                    Get.to(() => ViewLaporan());
                  }
                  if (value == "Akun") {
                    Get.to(() => UserListView());
                  }
                },
                itemBuilder: (BuildContext context) {
                  if (authController.role == "BPBD" && authController.acc) {
                    return [
                      PopupMenuItem(
                        value: "Laporan",
                        child: Text("Laporan"),
                      ),
                      PopupMenuItem(
                        value: "Akun",
                        child: Text("Akun"),
                      ),
                      PopupMenuItem(
                        value: "Rekomendasi",
                        child: Text("Rekomendasi"),
                      ),
                    ];
                  } else {
                    return [
                      PopupMenuItem(
                        value: "Rekomendasi",
                        child: Text("Rekomendasi"),
                      ),
                    ];
                  }
                },
              )
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
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('laporan')
                                .where('arsip', isEqualTo: false)
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
                                content: listlaporan(laporanList: laporanList, acc: authController.acc, akses: authController.role),
                              );
                            },
                          ),
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

class LevelController extends GetxController {
  var selectedLevel = 1.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
        .collection('settings')
        .doc('level')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        selectedLevel.value = snapshot['level'] ?? 1;
      }
    });
  }

  void setLevel(int level) {
    selectedLevel.value = level;
    _saveLevelToFirebase(level);
  }

  Future<void> _saveLevelToFirebase(int level) async {
    try {
      await FirebaseFirestore.instance.collection('settings').doc('level').set({
        'level': level,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving level to Firebase: $e');
    }
  }
}
