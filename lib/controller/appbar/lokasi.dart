import 'package:flutter/material.dart';

class lokasisaatini extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Lokasi Saat Ini", style: TextStyle(color: Colors.white, fontSize: 10),),
                            Text("Simpuruik Tanah Datar", style: TextStyle(color: Colors.white, fontSize: 10 , fontWeight: FontWeight.bold),) // ubah berdasarkan lokasi saat ini,
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 28,
                        width: 28,
                        child: GestureDetector(
                          onTap: (){},
                          child: Image.asset('assets/icons/destination.png'),
                        ),
                      )
                    ],
                  ),
                );
  }
}