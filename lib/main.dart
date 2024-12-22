import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/view/all/splash.dart';
import 'package:mea/view/all/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController()); // Inisialisasi AuthController

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authController.checkLoginStatus(), // Cek status login
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()), // Loader
            ),
          );
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: Obx(() {
            // Cek status login dan navigasi
            return authController.isLoggedIn.value
                ? ProfilePage(userid: authController.userId) // Navigasi menggunakan userId
                : SplashScreen();
          }),
        );
      },
    );
  }
}
  