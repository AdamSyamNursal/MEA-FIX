import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/model/modelpesan.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/pesan.dart'; // Import halaman Pesan

class Tambahpesan extends StatelessWidget {
  final String userid;
  final String role;

  Tambahpesan({required this.userid, required this.role});

  final TextEditingController namaPengirimController = TextEditingController();
  final TextEditingController pertanyaanController = TextEditingController();

  Future<void> tambahPesanKeFirebase() async {
    final String idPesan = FirebaseFirestore.instance.collection('pesan').doc().id;
    final ModelPesan pesan = ModelPesan(
      idPesan: idPesan,
      idUser: userid,
      namaPengirim: namaPengirimController.text.trim(),
      pertanyaan: pertanyaanController.text.trim(),
      role: role,
      timestamp: DateTime.now(),
      balasan: "",
    );

    await FirebaseFirestore.instance
        .collection('pesan')
        .doc(idPesan)
        .set(pesan.toJson());
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.arrow_back_rounded, color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Tambah Pesan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
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
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: 380,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: namaPengirimController,
                            decoration: InputDecoration(
                              hintText: "Masukkan Nama Pengirim",
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 380,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: pertanyaanController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Masukkan Pertanyaan",
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            if (namaPengirimController.text.isNotEmpty &&
                                pertanyaanController.text.isNotEmpty) {
                              await tambahPesanKeFirebase();

                              // Tampilkan Snackbar kecil
                              Get.snackbar(
                                "Berhasil",
                                "Pesan berhasil ditambahkan",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: Duration(seconds: 2),
                              );

                              // Navigasi ke halaman Pesan setelah 2 detik
                              Future.delayed(Duration(seconds: 2), () {
                                Get.to(() => Pesan(userId: '', role: '',)); // Navigasi mengganti halaman
                              });
                            } else {
                              Get.snackbar(
                                "Error",
                                "Semua field harus diisi",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Tambahkan",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
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
