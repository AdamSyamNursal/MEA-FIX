// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mea/controller/list/appbar.dart';
// import 'package:mea/controller/list/detail/deskripsiinformasi.dart';
// import 'package:mea/controller/list/detail/detaillokasi.dart';
// import 'package:mea/controller/list/detail/maps.dart';
// import 'package:mea/controller/list/detail/validdetail.dart';
// import 'package:mea/controller/list/sub/stacklaporan.dart';

// class Konfirmasilaporan extends StatefulWidget {
//   @override
//   _KonfirmasilaporanState createState() => _KonfirmasilaporanState();
// }

// class _KonfirmasilaporanState extends State<Konfirmasilaporan> {
//   bool isValid = false; // Status awal

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xFFFF6F00),
//         body: Column(
//           children: [
//             appbar(),
//             SizedBox(height: 10),
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 10),
//                       gambarstack(),
//                       maps(),
//                       SizedBox(height: 5),
//                       detaillokasi(),
//                       SizedBox(height: 5),
//                       deskripsilokasi(),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Row(
//                           children: [
//                             // Status Valid Detail
//                             Flexible(
//                               child: Validdetail(valid: isValid),
//                             ),
//                             SizedBox(width: 10),
//                             // Tombol Konfirmasi
//                             Container(
//                               child:Center(
//                                 child: ElevatedButton(
//                                 onPressed: () {
//                                   _showDropdown(context);
//                                 },
//                                 child: FittedBox(
//                                   child: Text("Konfirmasi"),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.orange,
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 12, horizontal: 16),
//                                 ),
//                               ),
//                               )
                              
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Fungsi Menampilkan Dropdown
//   void _showDropdown(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Pilih Status Validasi",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Color(0xFFFF6F00),
//                 ),
//               ),
//               SizedBox(height: 10),
//               DropdownButton<bool>(
//                 isExpanded: true,
//                 value: isValid,
//                 onChanged: (bool? newValue) {
//                   setState(() {
//                     isValid = newValue!;
//                   });
//                   Navigator.pop(context); // Menutup dropdown
//                 },
//                 items: [
//                   DropdownMenuItem(
//                     value: true,
//                     child: Text("Valid"),
//                   ),
//                   DropdownMenuItem(
//                     value: false,
//                     child: Text("Unvalid"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
