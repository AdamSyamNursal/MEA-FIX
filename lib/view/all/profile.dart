import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/widget/profilepage_login_register/editprofile.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/view/navigation_bar.dart';
import 'package:mea/widget/profilepage_login_register/profile/profileitem.dart';

class ProfilePage extends StatelessWidget {
  final String userid;

  ProfilePage({required this.userid});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      if (!authController.isLoggedIn.value) {
        return Login(); // Kembali ke halaman login jika logout
      }

      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFF6F00),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFFF6F00),
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Get.to(() => EditProfilePage(userid: userid));
                },
              ),
            ],
          ),
          body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(userid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(
                  child: Text(
                    "User data not found",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Profileitem(title: "Nama", value : userData['name'] ?? 'Tidak Diketahui'),
                            Profileitem(title: "Username", value : userData['username'] ?? 'Tidak Diketahui'),
                            Profileitem(title: "Email", value : userData['email'] ?? 'Tidak Diketahui'),
                            Profileitem(title:"Role", value: 
                              userData['acc'] == true
                                  ? (userData['role'] ?? 'Tidak Diketahui')
                                  : 'user',),
                            Profileitem(title: "Nomor Handphone", value : userData['phoneNumber'] ?? 'Tidak Diketahui'),
                            Profileitem(title: "Alamat", value : userData['address'] ?? 'Tidak Diketahui'),
                            Profileitem(title: "Tanggal Lahir", value : userData['dateOfBirth'] ?? 'Tidak Diketahui'),
                            Profileitem(title: "Tanggal Daftar", value : userData['registrationDate'] ?? 'Tidak Diketahui'),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: authController.logoutUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF6F00),
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                shadowColor: Colors.black.withOpacity(0.2),
                                elevation: 6,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.logout, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: CustomNavigationBar(
            authController: authController,
            currentIndex: 3,
          ),
        ),
      );
    });
  }

}
