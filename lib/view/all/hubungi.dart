import 'package:flutter/material.dart';
import 'package:mea/controller/appbar/burger/burger.dart';
import 'package:mea/controller/appbar/lokasi.dart';
import 'package:mea/view/all/dashboar.dart';

class Hubungi extends StatelessWidget {
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
              SizedBox(height: 20), // Mengurangi jarak di sini
              Container(
                height: 560,
                width: 357,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Kontak BPBD",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 15), // Mengurangi jarak di sini
                        Container(
                          width: 271,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Alamat : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Jl. Raya Batusangkar No.465, Limo Kaum, Kec. Lima Kaum, Kabupaten Tanah Datar, Sumatera Barat 27213",
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30), // Mengurangi jarak di sini
                        Center(
                          child: Text(
                            "Jam Aktivitas :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5), // Mengurangi jarak di sini
                        Container(
                          width: 300,
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Senin ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "07.30–16.00\n"),
                                  TextSpan(text: "Selasa ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "07.30–16.00\n"),
                                  TextSpan(text: "Rabu ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "07.30–16.00\n"),
                                  TextSpan(text: "Kamis ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "07.30–16.00\n"),
                                  TextSpan(text: "Jumat ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "07.30–16.30\n"),
                                  TextSpan(text: "Sabtu ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "Tutup\n"),
                                  TextSpan(text: "Minggu ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "Tutup"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60), // Mengurangi jarak di sini
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.asset('assets/images/BPBD.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
