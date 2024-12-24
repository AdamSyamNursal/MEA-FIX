import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/model/modelpesan.dart';
import 'package:mea/widget/pesan/detailpesan.dart';

class Controllerpesan extends StatelessWidget {
  final int bulan;
  final int tahun;
  final String role;

  Controllerpesan({required this.bulan, required this.tahun, required this.role});
  

  @override
  Widget build(BuildContext context) {
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
                      }
  }
