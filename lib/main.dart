import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/splash.dart';
import 'package:mea/view/all/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController()); // Inisialisasi AuthController

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder(
        future: authController.checkLoginStatus(), // Periksa status login
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan splash screen saat memeriksa status login
            return SplashScreen();
          } else {
            return Obx(() {
              // Tampilkan halaman sesuai status login
              return authController.isLoggedIn.value
                  ? dashboard() // Jika login, ke dashboard
                  : dashboard(); // Jika tidak login, ke login screen
            });
          }
        },
      ),
    );
  }
}
