import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/widget/dashboard/laporan/listlaporan/map/mapcontroller.dart';
import 'package:mea/view/navigation_bar.dart';
import 'package:mea/widget/tambahlaporan/buildtexfield.dart';
import 'package:mea/widget/tambahlaporan/controller/tambahlaporancontroller.dart';

class TambahLaporanView extends StatelessWidget {
  final String userId;
  final String role;

  TambahLaporanView({required this.userId, required this.role});

  final controller = Get.put(TambahLaporanController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFFF6F00),
          title: Text(
            "Tambah Laporan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
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
                      BuildTextField(label: "Nama Jalan", controller: controller.namaJalanController),
                      BuildTextField(label: "Kelurahan", controller: controller.kelurahanController),
                      BuildTextField(label: "Kecamatan", controller: controller.kecamatanController),
                      BuildTextField(label: "Kota", controller: controller.kotaController),
                      BuildTextField(label: "Provinsi", controller: controller.provinsiController),
                      BuildTextField(label: "Kode Pos", controller: controller.kodePosController),
                      SizedBox(height: 10),
                      BuildTextField(label: "Pengirim", controller: controller.pengirimController),
                      SizedBox(height: 10),
                      BuildTextField(label: "Alamat", controller: controller.alamatController),
                      SizedBox(height: 10),
                      BuildTextField(
                        label: "Keterangan",
                        controller: controller.keteranganController,
                        maxLines: 5,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.pickImage(),
                        child: Text('Pilih Gambar'),
                      ),
                      SizedBox(height: 10),
                      Obx(() => controller.selectedImage.value != null
                          ? Image.file(controller.selectedImage.value!, height: 150)
                          : Text('Belum ada gambar yang dipilih')),
                      SizedBox(height: 20),
                      Obx(() => Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isFormValid.value
                                  ? () => controller.kirimLaporan(userId, role)
                                  : null,
                              child: Text(
                                "Kirim Laporan",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.isFormValid.value
                                    ? Color(0xFFFF6F00)
                                    : Colors.grey,
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          authController: Get.find<AuthController>(),
          currentIndex: 1, // Set tab kedua sebagai aktif
        ),
      ),
    );
  }
}
