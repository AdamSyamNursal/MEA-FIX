import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:mea/view/all/login.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final newPasswordController = TextEditingController(); // Tambahkan field ini
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> verifyUser() async {
    final email = emailController.text.trim();
    final dob = dobController.text.trim();
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    try {
      final querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('dateOfBirth', isEqualTo: dob)
          .where('name', isEqualTo: name)
          .where('phoneNumber', isEqualTo: phone)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Get.to(() => PasswordResetView()); // Navigasi ke halaman PasswordResetView jika data cocok
      } else {
        Get.snackbar("Error", "Data tidak cocok dengan database.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

class ForgotPasswordView extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lupa Password"),
        backgroundColor: Color(0xFFFF6F00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: controller.dobController,
                decoration: InputDecoration(
                  labelText: "Tanggal Lahir (YYYY-MM-DD)",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: controller.verifyUser,
                  child: Text("Masukan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6F00),
                    minimumSize: Size(200, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
}

class PasswordResetView extends StatelessWidget {
  final ForgotPasswordController controller = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Color(0xFFFF6F00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password Baru",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final newPassword = controller.newPasswordController.text.trim();
                  if (newPassword.isEmpty) {
                    Get.snackbar("Error", "Password baru tidak boleh kosong.",
                        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }

                  try {
                    final hashedPassword = sha256.convert(utf8.encode(newPassword)).toString();
                    final querySnapshot = await controller.firestore
                        .collection('users')
                        .where('email', isEqualTo: controller.emailController.text.trim())
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      await querySnapshot.docs.first.reference.update({'password': hashedPassword});
                      Get.snackbar("Success", "Password berhasil direset.",
                          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
                      Get.offAll(() => Login()); // Navigasi kembali ke LoginView
                    }
                  } catch (e) {
                    Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}",
                        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                  }
                },
                child: Text("Reset Password"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6F00),
                  minimumSize: Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

