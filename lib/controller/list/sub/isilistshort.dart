

import 'package:flutter/material.dart';

class isilistshor extends StatelessWidget{
   // Tambahkan parameter untuk title
  final String content; // Tambahkan parameter untuk teks konten
  isilistshor({required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
                                    width: 160,
                                    height: 98,
                                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
                                    
                                    child: Text(content, maxLines: 3, overflow: TextOverflow.ellipsis,)
                                  );
  }
}

//   Widget _buildLaporanItem(Map<String, dynamic> laporan) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: ListTile(
//         title: Text(
//           laporan['nama_jalan'] ?? 'Nama Jalan Tidak Diketahui',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           laporan['keterangan'] ?? 'Keterangan Tidak Tersedia',
//         ),
//         trailing: Text(
//           laporan['tanggal'] != null
//               ? (laporan['tanggal'] as Timestamp).toDate().toString()
//               : 'Tanggal Tidak Diketahui',
//           style: TextStyle(color: Colors.grey, fontSize: 12),
//         ),
//       ),
//     );
//   }
// }