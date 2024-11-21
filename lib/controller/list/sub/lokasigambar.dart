import 'package:flutter/material.dart';

class lokasigambar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return                                 Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Image.asset('assets/icons/destination.png', width: 24, height: 24,),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Text("Simabur, Tanah Datar\n29 September 2024",style: TextStyle(height: 1, fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                ));
  }
}