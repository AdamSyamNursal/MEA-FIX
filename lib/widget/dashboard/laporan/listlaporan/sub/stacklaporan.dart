import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/sub/lokasigambar.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/sub/rolepengirim.dart';

class gambarstack extends StatelessWidget {
  final String? gambar; // Mengizinkan nilai null
  final String role;
  final bool acc;
  final String kecamatan;
  final String jorong;
  final Timestamp time;
  final String laporanId; // ID laporan untuk akses hapus
  final String akses;
  

  gambarstack({
    required this.role,
    required this.acc,
    this.gambar,
    required this.kecamatan,
    required this.jorong,
    required this.time,
    required this.laporanId,
    required this.akses,
    
  });

  void _deleteLaporan(BuildContext context) {
    if (akses == 'BPBD' && acc) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus laporan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup dialog
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('laporan')
                    .doc(laporanId)
                    .delete(); // Logika hapus laporan
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Laporan berhasil dihapus.')),
                );
              },
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Anda tidak memiliki izin untuk menghapus laporan ini.'),
        ),
      );
    }
  }

  void _updateAcc(BuildContext context) {
    FirebaseFirestore.instance
        .collection('laporan')
        .doc(laporanId)
        .update({'arsip': true})
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status laporan berhasil diperbarui.')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui status laporan.')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gambar utama
        Container(
          width: 330,
          height: 200,
          child: gambar == null || gambar!.isEmpty
              ? Image.asset(
                  'assets/images/contoh.png',
                  fit: BoxFit.cover,
                )
              : Image.network(
                  gambar!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/contoh.png', // Jika gambar gagal dimuat, tampilkan gambar default
                      fit: BoxFit.cover,
                    );
                  },
                ),
        ),
        // Informasi lokasi
        lokasigambar(
          kecamatan: kecamatan,
          jorong: jorong,
          time: time,
        ),
        // Informasi role pengirim
        rolepengirim(
          role: role,
          acc: acc,
        ),
        // Tombol hapus di atas gambar
        if (akses == 'BPBD' && acc)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background putih untuk kontras
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red, size: 24),
                onPressed: () => _deleteLaporan(context),
              ),
            ),
          ),
        // Tombol message di bawah tombol hapus
        if (akses == 'BPBD' && acc)
          Positioned(
            top: 60,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background putih untuk kontras
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.message, color: Colors.blue, size: 24),
                onPressed: () => _updateAcc(context),
              ),
            ),
          ),
      ],
    );
  }
}
