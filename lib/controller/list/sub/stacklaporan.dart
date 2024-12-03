import 'package:flutter/material.dart';
import 'package:mea/controller/list/sub/lokasigambar.dart';
import 'package:mea/controller/list/sub/rolepengirim.dart';

class gambarstack extends StatelessWidget {
  final String role;

  gambarstack({required this.role});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/contoh.png',
          width: 330,
          height: 200,
          fit: BoxFit.cover,
        ),
        lokasigambar(),
        rolepengirim(
          role: role, // Pastikan parameter role dikirim ke RolePengirim
        ),
      ],
    );
  }
}
