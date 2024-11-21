import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mea/controller/list/listlaporan.dart';

class Kosong extends StatelessWidget {
  final bool isilist;

  Kosong({required this.isilist});

  Widget ada() {
    if (isilist == true) {
      return listlaporan();
    } else {
      return Container(
        child: Column(
          children: [
            Center(
              child: Text("Arsip Kosong" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                child: Image.asset('assets/images/kosong.png',width: 250, height: 294, fit: BoxFit.fill,),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ada();
  }
}
