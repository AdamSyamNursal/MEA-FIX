
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/dashboar.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final authController = Get.put(AuthController());

  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  // Fungsi untuk hashing password
  String hashPassword(String password) {
    final bytes = utf8.encode(password); // Konversi password ke bytes
    final hashed = sha256.convert(bytes); // Hash dengan SHA256
    return hashed.toString(); // Kembalikan hasil hashing
  }

  Future<void> loginUser() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Username dan password tidak boleh kosong.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      // Hash password sebelum dibandingkan
      final hashedPassword = hashPassword(password);

      // Query Firestore untuk mencocokkan username dan password yang di-hash
      final querySnapshot = await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: hashedPassword)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        await authController.loginUser(userData); // Simpan sesi pengguna
        Get.offAll(() => dashboard());
      } else {
        Get.snackbar("Error", "Username atau password salah.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}