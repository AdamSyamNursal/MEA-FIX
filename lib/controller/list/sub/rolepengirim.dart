import 'package:flutter/material.dart';

class rolepengirim extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Positioned(
                                  bottom: 10,
                                  left: 0,
                                  right: 0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 100,
                                      height: 23,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/icons/relawan.png")
                                          ,Text("Relawan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                ));
  }
}