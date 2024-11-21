import 'package:flutter/material.dart';
import 'package:mea/view/all/detail.dart';

class Isilistvalid extends StatelessWidget{
  final bool valid;

  Isilistvalid ({required this.valid});

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detail(), // Ganti DetailPage dengan nama kelas halaman detail Anda
        ),
      );
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