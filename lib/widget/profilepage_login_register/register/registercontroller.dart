
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/model/modeluser.dart';
import 'package:mea/widget/profilepage_login_register/alert.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  var selectedRole = 'Relawan'.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fungsi untuk hashing password
  String hashPassword(String password) {
    final bytes = utf8.encode(password); // Konversi password ke bytes
    final hashed = sha256.convert(bytes); // Hash dengan SHA256
    return hashed.toString(); // Kembalikan hasil hashing
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    try {
      // Generate UUID untuk ID pengguna
      final userId = Uuid().v4();

      // Extract form values
      final name = nameController.text.trim();
      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final hashedPassword = hashPassword(passwordController.text); // Hash password
      final phoneNumber = phoneNumberController.text.trim();
      final address = addressController.text.trim();
      final dateOfBirth = dateOfBirthController.text.trim();
      final role = selectedRole.value;

      // Save user data to Firestore
      final user = UserModel(
        id: userId,
        name: name,
        username: username,
        email: email,
        password: hashedPassword, // Simpan password yang sudah di-hash
        role: role,
        phoneNumber: phoneNumber,
        address: address,
        dateOfBirth: dateOfBirth,
        registrationDate: DateTime.now().toIso8601String(),
        acc: false,
      );

      await firestore.collection('users').doc(userId).set(user.toJson());

      // Notifikasi sukses menggunakan Get.snackbar
      Get.snackbar(
        "Sukses",
        "Registrasi berhasil!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigasi ke Login menggunakan GetX
      Get.offAll(() => AlertPage());
    } catch (e) {
      // Notifikasi error menggunakan Get.snackbar
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}