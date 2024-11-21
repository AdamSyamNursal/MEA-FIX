import 'package:flutter/material.dart';

class maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13.0,),
            child: Text("Maps :", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          
          SizedBox(
            height: 5,
          ),
          Container(
            child: Image.asset("assets/images/contoh.png",
            width: 330, height: 200, fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}