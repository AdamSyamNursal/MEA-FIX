import 'package:flutter/material.dart';
import 'package:mea/controller/level.dart';
import 'package:mea/controller/list/appbar.dart';
import 'package:mea/controller/list/detail/deskripsiinformasi.dart';
import 'package:mea/controller/list/detail/detaillokasi.dart';
import 'package:mea/controller/list/detail/maps.dart';
import 'package:mea/controller/list/detail/validdetail.dart';
import 'package:mea/controller/list/listlaporan.dart';
import 'package:mea/controller/list/sub/stacklaporan.dart';
import 'package:mea/view/all/arsip.dart';

class Detail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child: 
    Scaffold(
      backgroundColor: Color(0xFFFF6F00),
      body:Container(
        child: Column(
          children: [
            Container(
  padding: EdgeInsets.symmetric(horizontal: 16), // Memberi jarak horizontal
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribusi elemen
    crossAxisAlignment: CrossAxisAlignment.center, // Menyelaraskan vertikal
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context); // Navigasi kembali
        },
        child: Container(
          height: 27,
          width: 27,
          child: Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.white,
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: Text(
            "Detail Laporan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      SizedBox(width: 27), // Spacer untuk menjaga layout seimbang
    ],
  ),
),
            SizedBox(height: 10,),
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
                      SizedBox(
                        height: 10,
                      ),
                      gambarstack(),
                      maps(),
                      SizedBox(
                        height: 5,
                      ),
                      detaillokasi(),
                      SizedBox(
                        height: 5,
                      ),
                      deskripsilokasi(),
                      SizedBox(
                        height: 10,
                      ),
                      Validdetail(valid: false,),
                      SizedBox(height: 10,)

                    ],
                  ),
                ),
              ),
          )
          ],
        ),
      )
    ));
  }
}

  // Widget _buildLaporanItem(Map<String, dynamic> laporan) {
  //   return Card(
  //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: ListTile(
  //       title: Text(
  //         laporan['alamat'] ?? 'Alamat Tidak Diketahui',
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       subtitle: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             laporan['keterangan'] ?? 'Keterangan Tidak Tersedia',
  //             style: TextStyle(color: Colors.grey[700]),
  //           ),
  //           SizedBox(height: 4),
  //           Text(
  //             'Role: ${laporan['role'] ?? 'Tidak Diketahui'}',
  //             style: TextStyle(color: Colors.grey[700]),
  //           ),
  //         ],
  //       ),
  //       trailing: Text(
  //         laporan['tanggal'] != null
  //             ? (laporan['tanggal'] as Timestamp).toDate().toString()
  //             : 'Tanggal Tidak Diketahui',
  //         style: TextStyle(color: Colors.grey, fontSize: 12),
  //       ),
  //     ),
  //   );
  // }