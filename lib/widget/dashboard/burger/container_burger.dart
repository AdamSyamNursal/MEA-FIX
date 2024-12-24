import 'package:flutter/material.dart';

class ContainerBurger extends StatelessWidget {
  final String texline;
  final VoidCallback onTap;

  const ContainerBurger({super.key, required this.texline, required this.onTap}); 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: 10), 
          Container(
            width: 357,
            height: 37,
            decoration: const BoxDecoration(color: Colors.white), 
            child: Center(
              child: Text(
                texline,
                style: const TextStyle(fontWeight: FontWeight.bold), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
