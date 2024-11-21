import 'package:flutter/material.dart';
import 'package:mea/view/all/splash.dart';
import 'package:mea/view/all/tentangaplikasi.dart';
import 'package:mea/view/all/hubungi.dart';
import 'package:mea/view/all/arsip.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEA App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Halaman utama
        '/tentangaplikasi': (context) => Tentangaplikasi(),
        '/hubungi': (context) => Hubungi(),
        '/arsip': (context) => arsip(),
      },
    );
  }
}
