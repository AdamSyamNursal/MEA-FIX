import 'package:flutter/material.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/appbar/lokasi.dart';

class appbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 56,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    burger(),
                    lokasisaatini(),
                  ],
          ),
          ),
        ]
      )
    );
  }
}
