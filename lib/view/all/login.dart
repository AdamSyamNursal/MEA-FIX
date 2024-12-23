import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/register.dart';
import 'package:mea/view/navigation_bar.dart';
import 'package:crypto/crypto.dart'; // Import untuk hashing
import 'dart:convert'; // Untuk utf8.encode

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

class Login extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => dashboard());
                    },
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 27),
                ],
              ),
            ),

            // White Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Login Image
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/images/loginimage.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Username Field
                      TextField(
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          hintText: "Nama/Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Password Field
                      Obx(() => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.obscureText.value,
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscureText.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          )),
                      SizedBox(height: 30),

                      // Login Button
                      ElevatedButton(
                        onPressed: controller.loginUser,
                        child: Text(
                          "Masuk",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6F00),
                          minimumSize: Size(300, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Register Button
                      OutlinedButton(
                        onPressed: () {
                          Get.to(() => Register());
                        },
                        child: Text(
                          "Daftar",
                          style: TextStyle(color: Color(0xFFFF6F00)),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(300, 45),
                          side: BorderSide(color: Color(0xFFFF6F00)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
        bottomNavigationBar: CustomNavigationBar(
          authController: Get.find<AuthController>(),
          currentIndex: 3, // Tab pertama untuk Login
        ),
      ),
    );
  }
}
