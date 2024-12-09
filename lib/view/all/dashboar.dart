import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/controller/level.dart';
import 'package:mea/controller/list/kosong.dart';
import 'package:mea/controller/list/listlaporan.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/laporan.dart';
import 'package:mea/view/all/laporan_aktivitas.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/view/all/pesan.dart';
import 'package:mea/view/all/profile.dart';
import 'package:mea/view/all/rekomendasi.dart';
import 'package:mea/view/all/tambahlaporan.dart';
import 'package:mea/view/all/tambahpesan.dart';
import 'package:mea/view/floating.dart';

class dashboard extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final LevelController levelController = Get.put(LevelController()); 

  void _handleNotificationAction(String value) {
    print("Notifikasi: $value");
  }

  
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
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      burger(),
                      PopupMenuButton<String>(
  onSelected: (String value) {
    if (value == "Rekomendasi") {
      Get.to(() => Rekomendasi(
        role : authController.role,
        acc : authController.acc
      ));
    }
    if (value == "Laporan"){
      Get.to(()=> ViewLaporan());
    }
    if(value == "Rekomendasi"){
      Get.to(()=>"");
    }
  },
  itemBuilder: (BuildContext context) {
    if (authController.role == "BPBD" && authController.acc) {
      // Jika role adalah BPBD, tampilkan semua opsi
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
      // Jika role bukan BPBD, hanya tampilkan opsi "Rekomendasi"
      return [
        PopupMenuItem(
          value: "Rekomendasi",
          child: Text("Rekomendasi"),
        ),
      ];
    }
  },
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6), // Ukuran lebih kecil
    decoration: BoxDecoration(
      color: Colors.orange, // Warna tombol
      borderRadius: BorderRadius.circular(6), // Sudut lebih kecil
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 1), // Posisi bayangan lebih dekat
          blurRadius: 2, // Jarak blur lebih kecil
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.notifications, color: Colors.white, size: 16), // Ikon lebih kecil
        SizedBox(width: 4),
        Text(
          "Rekomendasi",
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: 14, // Ukuran font lebih kecil
          ),
        ),
      ],
    ),
  ),
)




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
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Obx(() => Level(level: levelController.selectedLevel.value)), // Tetap dinamis dari LevelController
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
                                    _showEditDropdown(context); // Panggil fungsi dropdown
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                ),
                              SizedBox(width: authController.role == "BPBD" && authController.acc ? 10 : 0),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => LaporanAktivitas(role: authController.role, acc: authController.acc));
                                }, 
                                child: Container(
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 420,
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
                                content: listlaporan(laporanList: laporanList, acc : authController.acc),
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
                    if (authController.isLoggedIn.value) {
                      Get.to(() => Pesan(
                            userId: authController.userId,
                            role: authController.role,
                            acc : authController.acc
                          ));
                    } else {
                      Get.to(() => Pesan(
                            userId: '',
                            role: 'user',
                            acc: false,
                          ));
                    }
                    break;
                  case 3:
                    if (authController.isLoggedIn.value) {
                      Get.to(() => ProfilePage(
                            userid : authController.userId,
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
        'timestamp': FieldValue.serverTimestamp(), // Tambahkan timestamp
      });
    } catch (e) {
      print('Error saving level to Firebase: $e');
    }
  }
}
