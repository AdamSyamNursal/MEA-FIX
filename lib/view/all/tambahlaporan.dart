import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mea/controller/map/mapcontroller.dart';

import 'package:mea/model/modelaporan.dart';

class TambahLaporan extends StatefulWidget {
  final String userId;
  final String role;

  TambahLaporan({required this.userId, required this.role});

  @override
  _TambahLaporanState createState() => _TambahLaporanState();
}

class _TambahLaporanState extends State<TambahLaporan> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final TextEditingController _namaJalanController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _pengirimController = TextEditingController();

  File? _selectedImage;
  LatLng? _currentPosition;

  void _updateLocation(LatLng position) {
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: await _selectImageSource(),
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<ImageSource> _selectImageSource() async {
    final result = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Sumber Gambar'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text('Kamera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text('Galeri'),
          ),
        ],
      ),
    );
    return result ?? ImageSource.gallery;
  }

  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return null;

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _storage.ref().child('laporan_images').child(fileName);

      final uploadTask = ref.putFile(_selectedImage!);
      final snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengunggah gambar: ${e.toString()}')),
      );
      return null;
    }
  }

  Future<void> _kirimLaporan(BuildContext context) async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lokasi belum ditemukan!')),
      );
      return;
    }

    try {
      final imageUrl = await _uploadImage();

      final laporan = Laporan(
        id: '',
        namaJalan: _namaJalanController.text.trim(),
        kelurahan: _kelurahanController.text.trim(),
        kecamatan: _kecamatanController.text.trim(),
        kota: _kotaController.text.trim(),
        provinsi: _provinsiController.text.trim(),
        kodePos: _kodePosController.text.trim(),
        userId: widget.userId,
        role: widget.role,
        alamat: _alamatController.text.trim(),
        keterangan: _keteranganController.text.trim(),
        tanggal: DateTime.now(),
        valid: false,
        pengirim: _pengirimController.text.trim(),
        longitude: _currentPosition?.longitude,
        latitude: _currentPosition?.latitude,
        arsip: false,
      );

      final docRef = await _firestore.collection('laporan').add({
        ...laporan.toJson(),
        'imageUrl': imageUrl ?? '',
      });

      await docRef.update({'id': docRef.id});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Laporan berhasil dikirim!')),
      );

      _resetFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
      );
    }
  }

  void _resetFields() {
    _namaJalanController.clear();
    _kelurahanController.clear();
    _kecamatanController.clear();
    _kotaController.clear();
    _provinsiController.clear();
    _kodePosController.clear();
    _alamatController.clear();
    _keteranganController.clear();
    _pengirimController.clear();
    setState(() {
      _selectedImage = null;
      _currentPosition = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            SizedBox(height: 56),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                  SizedBox(width: 27),
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
                      MapController(onLocationChanged: _updateLocation),
                      SizedBox(height: 10),
                      _buildTextField("Nama Jalan", _namaJalanController),
                      _buildTextField("Kelurahan", _kelurahanController),
                      _buildTextField("Kecamatan", _kecamatanController),
                      _buildTextField("Kota", _kotaController),
                      _buildTextField("Provinsi", _provinsiController),
                      _buildTextField("Kode Pos", _kodePosController),
                      SizedBox(height: 10),
                      Text(
                        "Pengirim:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6F00),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTextField("Nama Pengirim", _pengirimController),
                      SizedBox(height: 10),
                      Text(
                        "Deskripsi Informasi:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6F00),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTextField("Alamat", _alamatController),
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
                      Text(
                        "Pilih Gambar:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6F00),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Pilih Gambar'),
                      ),
                      SizedBox(height: 10),
                      _selectedImage != null
                          ? Image.file(_selectedImage!, height: 150)
                          : Text('Belum ada gambar yang dipilih'),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _kirimLaporan(context),
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
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF6F00),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
