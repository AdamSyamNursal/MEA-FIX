import 'package:flutter/material.dart';

class Level extends StatelessWidget {
  final int level;

  Level ({required this.level});

  Color getbackround(){
    if(level == 4){
      return Color(0xFFCA0E00);
    }if(level == 3){
      return Color(0xFFFF6F00);
    }if(level == 2){
      return Color(0xFFFFD700);
    }if(level == 1){
      return Color(0xFF03A9F4);
    }else{
      return Color(0xfffffffff);
    }
  }

  String level_des(){
    if(level == 4){
      return "Level IV" ;
    }if(level == 3){
      return "Level III" ;
    }if(level == 2){
      return "Level II";
    }if(level == 1){
      return "Level I" ;
    }else{
      return "error";
    }
  }

  String level_av(){
    if(level == 4){
      return "AWAS" ;
    }if(level == 3){
      return "SIAGA" ;
    }if(level == 2){
      return "WASPADA";
    }if(level == 1){
      return "NORMAL" ;
    }else{
      return "error";
    }
  }

  String icons(){
    if(level == 4){
      return 'assets/icons/logo4.png';
    }    if(level == 3){
      return 'assets/icons/logo3.png';
    }    if(level == 2){
      return 'assets/icons/logo2.png';
    }    if(level == 1){
      return "assets/icons/logo1.png";
    }
    else{
      return 'error' ;
    }
  }

  Widget build (BuildContext context){
    return Container(
                        height: 188,
                        width: 365,
                        decoration: BoxDecoration(
                          color: getbackround(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  bottom: 3, 
                                  child: Container(
                                    width: 100, // Adjust to match text width
                                    height: 3,  // Thickness of the underline
                                    color: Colors.white, // Color of the underline
                                  ),
                                ),
                                Text(
                                  level_des(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Text(level_av(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 48,
                                  ),),
                                  Container(
                                    height: 60,
                                    width: 70,
                                    child: Image.asset(icons()),
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
  }
}