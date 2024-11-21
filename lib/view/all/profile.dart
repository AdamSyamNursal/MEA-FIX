import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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
          Navigator.pop(context); // Navigasi kembali
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

                      profileItem("Nama", "John Doe"),

                      profileItem("Username", "johndoe123"),

                      profileItem("Email", "johndoe@example.com"),

                      profileItem("Role", "User"),

                      profileItem("Nomor Handphone", "08123456789"),

                      profileItem("Alamat", "Jl. Mawar No. 10, Jakarta"),

                      profileItem("Tanggal Lahir", "1 Januari 1990"),

                      profileItem("Tanggal Daftar", "20 November 2024"),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Aksi untuk logout
                          },
                          child: Text("Logout" , style: TextStyle(color: Colors.white),),
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
