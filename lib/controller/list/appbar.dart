import 'package:flutter/material.dart';
import 'package:mea/controller/appbar/burger/burger.dart';

class AppBar extends StatelessWidget { 
  const AppBar({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Column( 
      children: [
        const SizedBox(
          height: 56, 
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 17.0), // Menambahkan 'const'
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Burger(), 
            ],
          ),
        ),
      ],
    );
  }
}
