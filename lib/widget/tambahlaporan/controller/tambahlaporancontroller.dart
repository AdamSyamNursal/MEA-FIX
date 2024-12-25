

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mea/model/modelaporan.dart';


class TambahLaporanController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final namaJalanController = TextEditingController();
  final jorongController = TextEditingController();
  final alamatController = TextEditingController();
  final keteranganController = TextEditingController();
  final pengirimController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  RxBool isFormValid = false.obs;
  RxString selectedKabupaten = "".obs;
  RxString selectedKecamatan = "".obs;

  void updateLocation(LatLng position) {
    currentPosition.value = position;
    _validateForm();
  }

  void _validateForm() {
    isFormValid.value =
        namaJalanController.text.isNotEmpty &&
        jorongController.text.isNotEmpty &&
        selectedKabupaten.value.isNotEmpty &&
        selectedKecamatan.value.isNotEmpty &&
        alamatController.text.isNotEmpty &&
        keteranganController.text.isNotEmpty &&
        pengirimController.text.isNotEmpty;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final source = await _selectImageSource();
    if (source == null) return;

    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
    _validateForm();
  }

  Future<ImageSource?> _selectImageSource() async {
    return await showDialog<ImageSource>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Pilih Sumber Gambar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                icon: Icon(Icons.camera_alt, color: Colors.white),
                label: Text('Kamera',style: TextStyle(
                  color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6F00),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
                icon: Icon(Icons.photo, color: Colors.white),
                label: Text('Galeri',style: TextStyle(
                  color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF6F00),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<String?> _uploadImage() async {
    if (selectedImage.value == null) return null;

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _storage.ref().child('laporan_images').child(fileName);

      final uploadTask = ref.putFile(selectedImage.value!);
      final snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengunggah gambar: ${e.toString()}');
      return null;
    }
  }

  Future<void> kirimLaporan(String userId, String role) async {
    if (currentPosition.value == null) {
      Get.snackbar('Error', 'Lokasi belum ditemukan!');
      return;
    }

    try {
      final imageUrl = await _uploadImage();

      final laporan = Laporan(
        id: '',
        namaJalan: namaJalanController.text.trim(),
        jorong: jorongController.text.trim(),
        kecamatan: selectedKecamatan.value.trim(),
        kabupaten: selectedKabupaten.value.trim(),
        userId: userId,
        role: role,
        alamat: alamatController.text.trim(),
        keterangan: keteranganController.text.trim(),
        tanggal: DateTime.now(),
        valid: false,
        pengirim: pengirimController.text.trim(),
        longitude: currentPosition.value?.longitude,
        latitude: currentPosition.value?.latitude,
        arsip: false,
        imageUrl: '',
      );

      final docRef = await _firestore.collection('laporan').add({
        ...laporan.toJson(),
        'imageUrl': imageUrl ?? '',
      });

      await docRef.update({'id': docRef.id});

      Get.snackbar('Sukses', 'Laporan berhasil dikirim!');

      resetFields();
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: ${e.toString()}');
    }
  }

  void resetFields() {
    namaJalanController.clear();
    jorongController.clear();
    selectedKecamatan.value = "";
    selectedKabupaten.value = "";
    alamatController.clear();
    keteranganController.clear();
    pengirimController.clear();
    selectedImage.value = null;
    currentPosition.value = null;
    _validateForm();
  }
}