import 'package:flutter/material.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/appbar/lokasi.dart';
import 'package:mea/controller/arsip/dropdown.dart';
import 'package:mea/controller/level.dart';
import 'package:mea/controller/list/kosong.dart';
import 'package:mea/controller/list/listlaporan.dart';
import 'package:mea/view/all/dashboar.dart';

class arsip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 56),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
  height: 27,
  width: 27,
  child: GestureDetector(
    onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => dashboard(), // Navigasi ke dashboard
        ),
      );
    },
    child: Icon(
      Icons.keyboard_backspace_rounded,
      color: Colors.white,
    ),
  ),
),
                    lokasisaatini(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Arsip",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //DropdownBulan(),
                            SizedBox(width: 10),
                            //DropdownTahun(),
                          ],
                        ),
                        SizedBox(height: 10),
                        //Kosong(isilist: false),
                        SizedBox(height: 10),
                        
                        
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

