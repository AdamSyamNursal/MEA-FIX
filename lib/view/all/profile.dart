import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/login.dart';

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
                  SizedBox(height: 56),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(()=>dashboard());
                          },
                          child: Icon(Icons.keyboard_backspace_rounded, color: Colors.white),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 27),
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
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            profileItem("Nama", userData['name'] ?? 'Tidak Diketahui'),
                            profileItem("Username", userData['username'] ?? 'Tidak Diketahui'),
                            profileItem("Email", userData['email'] ?? 'Tidak Diketahui'),
profileItem(
  "Role",
  userData['acc'] == true
      ? (userData['role'] ?? 'Tidak Diketahui')
      : 'user',
),
 
                            profileItem("Nomor Handphone", userData['phoneNumber'] ?? 'Tidak Diketahui'),
                            profileItem("Alamat", userData['address'] ?? 'Tidak Diketahui'),
                            profileItem("Tanggal Lahir", userData['dateOfBirth'] ?? 'Tidak Diketahui'),
                            profileItem("Tanggal Daftar", userData['registrationDate'] ?? 'Tidak Diketahui'),
                            SizedBox(height: 20),
ElevatedButton(
  onPressed: authController.logoutUser,
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFFF6F00), // Warna tombol
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30), // Padding lebih lebar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Tombol dengan sudut melengkung
    ),
    shadowColor: Colors.black.withOpacity(0.2), // Bayangan tombol
    elevation: 6, // Efek elevasi tombol
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center, // Memastikan teks ada di tengah
    children: [
      Icon(Icons.logout, color: Colors.white), // Ikon logout
      SizedBox(width: 10), // Jarak antara ikon dan teks
      Text(
        "Logout",
        style: TextStyle(
          fontSize: 18, // Ukuran teks lebih besar
          fontWeight: FontWeight.bold,
          color: Colors.white, // Warna teks
        ),
      ),
    ],
  ),
)

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget profileItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF6F00),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
