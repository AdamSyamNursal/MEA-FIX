import 'package:flutter/material.dart';

class Akun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 56),
              Container(
                child: Center(
                  child: Text(
                    "Akun",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
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
                        SizedBox(height: 20),
                        // Akun Relawan
                        akunCard(
                          context,
                          nama: "John Doe",
                          username: "johndoe123",
                          email: "johndoe@example.com",
                          role: "Relawan",
                          nomorHp: "08123456789",
                          alamat: "Jl. Mawar No. 10, Jakarta",
                          tanggalLahir: "1 Januari 1990",
                          tanggalJoin: "20 November 2020",
                          warnaStatus: Colors.green,
                        ),
                        SizedBox(height: 20),
                        // Akun Guest
                        akunCard(
                          context,
                          nama: "Jane Smith",
                          username: "janesmith456",
                          email: "janesmith@example.com",
                          role: "Guest",
                          nomorHp: "08213456789",
                          alamat: "Jl. Melati No. 5, Bandung",
                          tanggalLahir: "15 Maret 1995",
                          tanggalJoin: "10 Oktober 2022",
                          warnaStatus: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Akun Card
  Widget akunCard(
    BuildContext context, {
    required String nama,
    required String username,
    required String email,
    required String role,
    required String nomorHp,
    required String alamat,
    required String tanggalLahir,
    required String tanggalJoin,
    required Color warnaStatus,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              nama,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Username: $username"),
          Text("Email: $email"),
          Text("Role: $role"),
          Text("Nomor HP: $nomorHp"),
          Text("Alamat: $alamat"),
          Text("Tanggal Lahir: $tanggalLahir"),
          Text("Tanggal Join: $tanggalJoin"),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: warnaStatus,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                role.toUpperCase(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
