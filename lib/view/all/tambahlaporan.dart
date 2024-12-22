import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mea/controller/map/mapcontroller.dart';
import 'package:mea/model/modelaporan.dart';

class TambahLaporanController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final namaJalanController = TextEditingController();
  final kelurahanController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kotaController = TextEditingController();
  final provinsiController = TextEditingController();
  final kodePosController = TextEditingController();
  final alamatController = TextEditingController();
  final keteranganController = TextEditingController();
  final pengirimController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);

  void updateLocation(LatLng position) {
    currentPosition.value = position;
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
  }

  Future<ImageSource?> _selectImageSource() async {
    return await Get.defaultDialog<ImageSource>(
      title: 'Pilih Sumber Gambar',
      content: Column(
        children: [
          ElevatedButton(
            onPressed: () => Get.back(result: ImageSource.camera),
            child: Text('Kamera'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: ImageSource.gallery),
            child: Text('Galeri'),
          ),
        ],
      ),
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
        kelurahan: kelurahanController.text.trim(),
        kecamatan: kecamatanController.text.trim(),
        kota: kotaController.text.trim(),
        provinsi: provinsiController.text.trim(),
        kodePos: kodePosController.text.trim(),
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
    kelurahanController.clear();
    kecamatanController.clear();
    kotaController.clear();
    provinsiController.clear();
    kodePosController.clear();
    alamatController.clear();
    keteranganController.clear();
    pengirimController.clear();
    selectedImage.value = null;
    currentPosition.value = null;
  }
}

class TambahLaporanView extends StatelessWidget {
  final String userId;
  final String role;

  TambahLaporanView({required this.userId, required this.role});

  final controller = Get.put(TambahLaporanController());

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
                    onTap: () => Get.back(),
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
                      MapController(onLocationChanged: controller.updateLocation),
                      SizedBox(height: 10),
                      _buildTextField("Nama Jalan", controller.namaJalanController),
                      _buildTextField("Kelurahan", controller.kelurahanController),
                      _buildTextField("Kecamatan", controller.kecamatanController),
                      _buildTextField("Kota", controller.kotaController),
                      _buildTextField("Provinsi", controller.provinsiController),
                      _buildTextField("Kode Pos", controller.kodePosController),
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
                      _buildTextField("Nama Pengirim", controller.pengirimController),
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
                      _buildTextField("Alamat", controller.alamatController),
                      SizedBox(height: 10),
                      TextField(
                        controller: controller.keteranganController,
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
                        onPressed: () => controller.pickImage(),
                        child: Text('Pilih Gambar'),
                      ),
                      SizedBox(height: 10),
                      Obx(() => controller.selectedImage.value != null
                          ? Image.file(controller.selectedImage.value!, height: 150)
                          : Text('Belum ada gambar yang dipilih')),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.kirimLaporan(userId, role),
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


