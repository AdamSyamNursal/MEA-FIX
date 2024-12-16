import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/controller/arsip/dropdown.dart';
import 'package:mea/model/modelpesan.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/view/all/detailpesan.dart';
import 'package:mea/view/all/tambahpesan.dart';

class Pesan extends StatelessWidget {
  final String userId;
  final String role;
  final bool acc;
  final PesanFilterController controller = Get.put(PesanFilterController());

  Pesan({required this.userId, required this.role, required this.acc});

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
                      Get.to(() => dashboard());
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
                        "Pesan",
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
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownBulan(),
                        SizedBox(width: 10),
                        DropdownTahun(),
                      ],
                    ),
                    Expanded(
                      child: Obx(() {
                        final bulan = controller.bulanTerpilih;
                        final tahun = controller.tahunTerpilih;

                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('pesan').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  "Tidak ada pesan",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }

                            // Filter data berdasarkan bulan dan tahun
                            final List<QueryDocumentSnapshot> docs = snapshot.data!.docs.where((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              final String timestampString = data['timestamp'] ?? '';
                              try {
                                final timestamp = DateTime.parse(timestampString);
                                return timestamp.year == tahun && timestamp.month == bulan;
                              } catch (e) {
                                return false; // Abaikan data jika parsing gagal
                              }
                            }).toList();

                            if (docs.isEmpty) {
                              return Center(
                                child: Text(
                                  "Tidak ada pesan",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                final pesan = ModelPesan.fromJson(docs[index].data() as Map<String, dynamic>);

                                // Menentukan warna dan ikon berdasarkan role
                                final Color textColor = (pesan.role == 'Relawan')
                                    ? Colors.green
                                    : (pesan.role == 'user')
                                        ? Colors.red
                                        : Colors.red;
                                final String iconPath = (pesan.role == 'Relawan')
                                    ? 'assets/icons/relawan.png'
                                    : (pesan.role == 'user')
                                        ? 'assets/icons/masyarakat.png'
                                        : 'assets/icons/masyarakat.png';

                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  leading: Image.asset(
                                    iconPath,
                                    width: pesan.role == 'user' ? 30 : 25, // Ukuran lebih kecil untuk 'masyarakat'
                                    height: pesan.role == 'user' ? 30 : 25, // Ukuran lebih kecil untuk 'masyarakat'
                                    fit: BoxFit.contain,
                                  ),
                                  title: Text(
                                    pesan.namaPengirim,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                                  ),
                                  subtitle: Text(
                                    pesan.pertanyaan,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Text(
                                    "${pesan.timestamp.day}/${pesan.timestamp.month}/${pesan.timestamp.year}",
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                  onTap: () {
                                    Get.to(() => DetailPesan(pesan: pesan, role: role));
                                  },
                                );
                              },
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Tampilkan FAB hanya jika role bukan 'BPBD'
        floatingActionButton: (role != 'BPBD' || acc != true) 
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => Tambahpesan(
                        userid: userId,
                        role: role,
                      ));
                },
                backgroundColor: Color(0xFFFF6F00),
                child: Icon(Icons.add, color: Colors.white),
              )
            : null,
      ),
    );
  }
}
