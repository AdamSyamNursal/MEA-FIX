import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mea/view/all/dashboar.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  ProfilePage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            SizedBox(height: 56),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16), // Memberi jarak horizontal
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribusi elemen
                crossAxisAlignment: CrossAxisAlignment.center, // Menyelaraskan vertikal
                children: [
                  GestureDetector(
onTap: () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => dashboard(), // Ganti ke halaman Dasbor
    ),
  );
},

                    child: Container(
                      height: 27,
                      width: 27,
                      child: Icon(
                        Icons.keyboard_backspace_rounded,
                        color: Colors.white,
                      ),
                    ),
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
                  SizedBox(width: 27), // Spacer untuk menjaga layout seimbang
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
                      profileItem("Role", userData['role'] ?? 'Tidak Diketahui'),
                      profileItem("Nomor Handphone", userData['phoneNumber'] ?? 'Tidak Diketahui'),
                      profileItem("Alamat", userData['address'] ?? 'Tidak Diketahui'),
                      profileItem("Tanggal Lahir", userData['dateOfBirth'] ?? 'Tidak Diketahui'),
                      profileItem("Tanggal Daftar", userData['registrationDate'] ?? 'Tidak Diketahui'),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Aksi untuk logout
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF6F00),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Reusable untuk Item Profile
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
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
