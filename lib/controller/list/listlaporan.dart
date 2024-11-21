import 'package:flutter/material.dart';
import 'package:mea/controller/list/sub/isilistshort.dart';
import 'package:mea/controller/list/sub/isilistvalid.dart';
import 'package:mea/controller/list/sub/lokasigambar.dart';
import 'package:mea/controller/list/sub/rolepengirim.dart';
import 'package:mea/controller/list/sub/stacklaporan.dart';

class listlaporan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return 
    Container(
                        height: 300,
                        width: 330,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Warna bayangan dengan transparansi
                              spreadRadius: 5, // Penyebaran bayangan
                              blurRadius: 10, // Keburaman bayangan
                              offset: Offset(0, 4), // Posisi bayangan (x, y)
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            gambarstack(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  isilistshor(),
                                  Isilistvalid(valid: true,),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
  }
}