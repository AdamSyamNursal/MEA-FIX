import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditLaporanAktivitas extends StatelessWidget {
  final TextEditingController meteorologistController = TextEditingController();
  final TextEditingController visualController = TextEditingController();
  final TextEditingController kegempaanController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jamController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            SizedBox(height: 56),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
                    child: Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Edit Laporan Aktivitas",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(width: 15), // Placeholder untuk menjaga posisi simetris
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Input untuk Meteorologist
                      _buildInputField(
                        label: "Meteorologist",
                        controller: meteorologistController,
                        hintText: "Masukkan informasi meteorologist",
                      ),
                      SizedBox(height: 15),
                      // Input untuk Visual
                      _buildInputField(
                        label: "Visual",
                        controller: visualController,
                        hintText: "Masukkan informasi visual",
                      ),
                      SizedBox(height: 15),
                      // Input untuk Kegempaan
                      _buildInputField(
                        label: "Kegempaan",
                        controller: kegempaanController,
                        hintText: "Masukkan informasi kegempaan",
                      ),
                      SizedBox(height: 15),
                      // Input untuk Keterangan
                      _buildInputField(
                        label: "Keterangan",
                        controller: keteranganController,
                        hintText: "Masukkan keterangan tambahan",
                      ),
                      SizedBox(height: 15),
                      // Input untuk Tanggal
                      _buildInputField(
                        label: "Tanggal",
                        controller: tanggalController,
                        hintText: "Masukkan tanggal (YYYY-MM-DD)",
                      ),
                      SizedBox(height: 15),
                      // Input untuk Jam
                      _buildInputField(
                        label: "Jam",
                        controller: jamController,
                        hintText: "Masukkan jam (HH:MM)",
                      ),
                      SizedBox(height: 30),
                      // Tombol Simpan
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _saveLaporan(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Simpan",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }

  // Widget untuk membuat input field
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: null, // Mengatur agar teks dapat melanjutkan ke bawah
          minLines: 1, // Garis minimum untuk teks
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Fungsi untuk menyimpan laporan ke Firebase
  void _saveLaporan(BuildContext context) async {
    try {
      // Membuat data laporan detail
      final detailLaporan = {
        'meteorologist': meteorologistController.text,
        'visual': visualController.text,
        'kegempaan': kegempaanController.text,
        'keterangan': keteranganController.text,
        'tanggal': tanggalController.text,
        'jam': jamController.text,
        'timestamp': Timestamp.now(), // Waktu saat ini
      };

      // Simpan ke koleksi "detailLaporan" di Firestore
      await FirebaseFirestore.instance.collection('detailLaporan').add(detailLaporan);

      // Menampilkan notifikasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Detail laporan berhasil disimpan!")),
      );

      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } catch (e) {
      // Menampilkan notifikasi error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan detail laporan: $e")),
      );
    }
  }
}
