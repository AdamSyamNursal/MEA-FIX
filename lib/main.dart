import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Tambahkan GetX
import 'package:mea/view/all/splash.dart';
import 'package:mea/view/all/tentangaplikasi.dart';
import 'package:mea/view/all/hubungi.dart';
import 'package:mea/view/all/arsip.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Ganti MaterialApp dengan GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'MEA App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/', // Rute awal
      getPages: [
        // Daftar halaman dengan rute menggunakan GetPage
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/tentangaplikasi', page: () => Tentangaplikasi()),
        GetPage(name: '/hubungi', page: () => Hubungi()),
        GetPage(name: '/arsip', page: () => arsip()),
      ],
    );
  }
}
