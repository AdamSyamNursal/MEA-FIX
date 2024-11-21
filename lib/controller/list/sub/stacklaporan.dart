import 'package:flutter/material.dart';
import 'package:mea/controller/list/sub/lokasigambar.dart';
import 'package:mea/controller/list/sub/rolepengirim.dart';

class gambarstack extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
                              children: [
                                Image.asset('assets/images/contoh.png',
                                width: 330, height: 200, fit: BoxFit.cover,),
                                lokasigambar()
                                ,rolepengirim()
                              ],
                            );
  }
}