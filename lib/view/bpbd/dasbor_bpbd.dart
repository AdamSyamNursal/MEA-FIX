// import 'package:flutter/material.dart';
// import 'package:mea/controller/appbar/burger/burger.dart';
// import 'package:mea/controller/appbar/lokasi.dart';
// import 'package:mea/controller/level.dart';
// import 'package:mea/controller/list/listlaporan.dart';

// class DasborBpbd extends StatefulWidget {
//   @override
//   _DasborBpbdState createState() => _DasborBpbdState();
// }

// class _DasborBpbdState extends State<DasborBpbd> {
//   String selectedLevel = "Pilih Level"; // Level default

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xFFFF6F00),
//         body: Container(
//           child: Column(
//             children: [
//               SizedBox(height: 56),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 17.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     burger(),
//                     lokasisaatini(),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 10),
//                         Level(level: 1),
//                         SizedBox(height: 10),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 17.0),
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 // Tombol Edit
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     _showEditDropdown(context);
//                                   },
//                                   child: Text("Edit", style: TextStyle(color: Colors.white),),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.orange,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 // Tombol Notifikasi
//                                 PopupMenuButton<String>(
//                                   onSelected: (String value) {
//                                     _handleNotificationAction(value);
//                                   },
//                                   itemBuilder: (BuildContext context) {
//                                     return [
//                                       PopupMenuItem(
//                                         value: "Laporan",
//                                         child: Text("Laporan"),
//                                       ),
//                                       PopupMenuItem(
//                                         value: "Akun",
//                                         child: Text("Akun"),
//                                       ),
//                                     ];
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.notifications,
//                                           color: Colors.black),
//                                       SizedBox(width: 5),
//                                       Text(
//                                         "Notifikasi",
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 // Tombol Detail
//                                 Container(
//                                   height: 34,
//                                   width: 84,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(color: Colors.black),
//                                   ),
//                                   child: Container(
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text("Detail"),
//                                         Icon(Icons.arrow_right_sharp, size: 30),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         listlaporan(),
//                         SizedBox(height: 10),
//                         listlaporan(),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Fungsi Menampilkan Dropdown Edit Level
//   void _showEditDropdown(BuildContext context) {
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
//                 "Edit Level",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Color(0xFFFF6F00),
//                 ),
//               ),
//               SizedBox(height: 10),
//               DropdownButton<String>(
//                 isExpanded: true,
//                 value: selectedLevel,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedLevel = newValue!;
//                   });
//                   Navigator.pop(context);
//                 },
//                 items: [
//                   "Pilih Level",
//                   "Awas",
//                   "Siaga",
//                   "Waspada",
//                   "Normal",
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Fungsi Handle Aksi Notifikasi
//   void _handleNotificationAction(String value) {
//     if (value == "Laporan") {
//       print("Laporan dipilih");
//       // Tambahkan aksi untuk "Laporan"
//     } else if (value == "Akun") {
//       print("Akun dipilih");
//       // Tambahkan aksi untuk "Akun"
//     }
//   }
// }
