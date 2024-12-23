import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/tambahlaporan.dart';
import 'package:mea/view/all/pesan.dart';
import 'package:mea/view/all/profile.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/controller/auth/auth_controller.dart';

class CustomNavigationBar extends StatelessWidget {
  final AuthController authController;
  final int currentIndex;

  CustomNavigationBar({required this.authController, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFF6F00),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              Get.offAll(() => dashboard()); // OffAll untuk reset stack navigasi
              break;
                  case 1:
                    if (authController.isLoggedIn.value) {
                      Get.to(() => TambahLaporanView(
                            userId: authController.userId,
                            role: authController.role,
                            
                          ));
                    } else {
                      Get.to(() => TambahLaporanView(
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
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Tambah',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Pesan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
