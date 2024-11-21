import 'package:flutter/material.dart';

class Validdetail extends StatelessWidget {

  final bool valid;
  Validdetail ({required this.valid});

  Color kotakvalid(){
    if (valid == true){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }

  String desk_valid() {
    if(valid == true){
      return "Valid";
    }else{
      return "Unvalid";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 40,
      decoration: BoxDecoration(
        color: kotakvalid(),
        borderRadius: BorderRadius.circular(20), // Menambahkan radius 20
      ),
      child: Center(
        child: Text(
          desk_valid(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
