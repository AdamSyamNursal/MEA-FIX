import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mea/controller/list/listlaporan.dart';
import 'package:mea/view/all/container_msg.dart';

class PesanKosong extends StatelessWidget {
  final bool isipesan;

  PesanKosong({required this.isipesan});

  Widget ada() {
    if (isipesan == true) {
      return ContainerMsg();
    } else {
      return Container(
        child: Column(
          children: [
            Center(
              child: Text("Pesan Kosong" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),),
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
