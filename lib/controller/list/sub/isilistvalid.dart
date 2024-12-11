import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/detail.dart';

class Isilistvalid extends StatelessWidget{
  final bool valid;
  final String idLaporan;
  final String akses;

  Isilistvalid ({required this.valid, required this.idLaporan, required this.akses});

  Color backgroundColor(){
    if (valid == true){
      return Color.fromARGB(255, 21, 255, 0);
    }else{
      return Color.fromARGB(255, 202, 13, 0);
    }
  }

  String textvalid(){
    if(valid == true){
      return "VALID";
    }
    else{
      return "UNVALID";
    }
  }

  Widget build(BuildContext context) {
    return Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: backgroundColor()
                                          ),
                                          child: Center(child: Text(textvalid(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),),),
                                        ),
Container(
  child: GestureDetector(
    onTap: () {
      Get.to(() => Detail(idLaporan: idLaporan, akses : akses));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Detail"),
        SizedBox(height: 5),
        Icon(Icons.arrow_right_outlined),
      ],
    ),
  ),
)

                                      ],
                                    ),
                                  );
  }
}