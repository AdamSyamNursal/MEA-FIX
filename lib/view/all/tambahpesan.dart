import 'package:flutter/material.dart';
import 'package:mea/controller/arsip/dropdown.dart';
import 'package:mea/controller/pesan/pesan_kosong.dart';
import 'package:mea/view/all/container_msg.dart';

class Tambahpesan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 56),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Tambah Pesan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
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
                        Container(
                          child: Center(
                            child: Text("14-11-2024"),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 380,
                          height: 130,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                child: Row(
                                  children: [
                                    Image.asset("assets/icons/relawan.png"),
                                    SizedBox(width: 10),
                                    Text(
                                      "Junaidi",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                width: double.infinity,
                                height: 64,
                                child: TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Pertanyaan",
                                    hintStyle: TextStyle(fontSize: 14),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
  onTap: () {
    // Add your button functionality here
  },
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 102,
          height: 39,
          decoration: BoxDecoration(
      color: Colors.orange, // Set your button color
      borderRadius: BorderRadius.circular(20),
    ),
          child: Center(
            child: Text(
          "Tambahkan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Set text color
        ),
          ) 
        ),
        
      ],
    ),
  ),
)

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
