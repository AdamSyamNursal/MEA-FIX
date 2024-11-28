import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/appbar/lokasi.dart';
import 'package:mea/controller/auth/auth_controller.dart'; // AuthController untuk autentikasi
import 'package:mea/controller/level.dart';
import 'package:mea/view/all/laporan_aktivitas.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/view/all/pesan.dart';
import 'package:mea/view/all/profile.dart';
import 'package:mea/view/all/tambahlaporan.dart'; // Halaman TambahLaporan
import 'package:mea/view/floating.dart';

class dashboard extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>(); // Ambil AuthController

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
                          return Center(
                            child: Text(
                              'Belum ada laporan.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }

                        final laporanList = snapshot.data!.docs;

                        return ListView.builder(
                          padding: EdgeInsets.only(bottom: 80),
                          itemCount: laporanList.length,
                          itemBuilder: (context, index) {
                            final laporan = laporanList[index].data() as Map<String, dynamic>;
                            return _buildLaporanItem(laporan);
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            // FloatingNavbar dengan navigasi
            FloatingNavbar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    Get.to(() => dashboard());
                    break;
                  case 1:
                    if (authController.isLoggedIn.value) {
                      Get.to(() => TambahLaporan(userId: authController.userId, role: authController.role,));
                    } else {
                      Get.to(() => TambahLaporan(userId: '', role: 'user',));
                    }
                    break;
                  case 2:
                    Get.to(() => Pesan());
                    break;
                  case 3:
                    if (authController.isLoggedIn.value) {
                      Get.to(() => ProfilePage(
                          userData: authController.userData.value));
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

  // Widget untuk menampilkan item laporan
  Widget _buildLaporanItem(Map<String, dynamic> laporan) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          laporan['alamat'] ?? 'Alamat Tidak Diketahui',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              laporan['keterangan'] ?? 'Keterangan Tidak Tersedia',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 4),
            Text(
              'Role: ${laporan['role'] ?? 'Tidak Diketahui'}',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
        trailing: Text(
          laporan['tanggal'] != null
              ? (laporan['tanggal'] as Timestamp).toDate().toString()
              : 'Tanggal Tidak Diketahui',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }
}
