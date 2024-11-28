import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mea/model/modelaporan.dart';

class TambahLaporan extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controllers untuk setiap field input
  final TextEditingController _namaJalanController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  final String userId; // ID pengguna
  final String role; // Role pengguna

  TambahLaporan({required this.userId, required this.role});

  Future<void> _kirimLaporan(BuildContext context) async {
    try {
      // Data sementara untuk laporan tanpa ID
      final laporan = Laporan(
        id: '', // ID akan ditambahkan setelah dokumen dibuat
        namaJalan: _namaJalanController.text.trim(),
        kelurahan: _kelurahanController.text.trim(),
        kecamatan: _kecamatanController.text.trim(),
        kota: _kotaController.text.trim(),
        provinsi: _provinsiController.text.trim(),
        kodePos: _kodePosController.text.trim(),
        userId: userId, // ID pengguna dari parameter
        role: role, // Role pengguna dari parameter
        alamat: _alamatController.text.trim(),
        keterangan: _keteranganController.text.trim(),
        tanggal: DateTime.now(), // Waktu laporan dibuat
        valid: false,
      );

      // Tambahkan data ke Firestore
      final docRef = await _firestore.collection('laporan').add(laporan.toJson());

      // Setelah dokumen dibuat, update ID laporan
      await docRef.update({'id': docRef.id});

      // Notifikasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Laporan berhasil dikirim!')),
      );

      // Reset semua field setelah sukses mengirim laporan
      _namaJalanController.clear();
      _kelurahanController.clear();
      _kecamatanController.clear();
      _kotaController.clear();
      _provinsiController.clear();
      _kodePosController.clear();
      _alamatController.clear();
      _keteranganController.clear();
    } catch (e) {
      // Notifikasi error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
      );
    }
  }

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
                          "Tambah Laporan",
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
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Detail Lokasi
                        Text(
                          "Detail Lokasi:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6F00),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _namaJalanController,
                          decoration: InputDecoration(
                            labelText: "Nama Jalan",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _kelurahanController,
                          decoration: InputDecoration(
                            labelText: "Kelurahan",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _kecamatanController,
                          decoration: InputDecoration(
                            labelText: "Kecamatan",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _kotaController,
                          decoration: InputDecoration(
                            labelText: "Kota",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _provinsiController,
                          decoration: InputDecoration(
                            labelText: "Provinsi",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _kodePosController,
                          decoration: InputDecoration(
                            labelText: "Kode Pos",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Deskripsi Informasi
                        Text(
                          "Deskripsi Informasi:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6F00),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _alamatController,
                          decoration: InputDecoration(
                            labelText: "Alamat",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _keteranganController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "Keterangan",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Button Submit
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _kirimLaporan(context); // Panggil fungsi untuk kirim laporan
                            },
                            child: Text(
                              "Kirim Laporan",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF6F00),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
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
