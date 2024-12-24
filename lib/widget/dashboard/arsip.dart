import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mea/controller/arsip/dropdown.dart';
import 'package:mea/controller/arsip/PesanFilterController.dart';
import 'package:mea/model/modelaporan.dart';

class Arsip extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Laporan"),
        backgroundColor: Color(0xFFFF6F00),
      ),
      body: Column(
        children: [
          // Dropdown untuk filter bulan dan tahun
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownBulan(),
                DropdownTahun(),
              ],
            ),
          ),

          // Tampilan laporan berdasarkan filter
          Expanded(
            child: Obx(
              () {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('laporan')
                      .where(
                        'tanggal',
                        isGreaterThanOrEqualTo: DateTime(
                            controller.tahunTerpilih, controller.bulanTerpilih, 1),
                      )
                      .where(
                        'tanggal',
                        isLessThan: DateTime(
                            controller.tahunTerpilih, controller.bulanTerpilih + 1, 1),
                      )
                      .where('arsip', isEqualTo: true) // Filter arsip == true
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error loading data",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No laporan found",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    // Mengubah dokumen Firestore menjadi list objek Laporan
                    final List<Laporan> laporanList = snapshot.data!.docs.map((doc) {
                      return Laporan.fromJson(
                          doc.id, doc.data() as Map<String, dynamic>);
                    }).toList();

                    return ListView.builder(
                      itemCount: laporanList.length,
                      itemBuilder: (context, index) {
                        final laporan = laporanList[index];

                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: ListTile(
leading: GestureDetector(
  onTap: () {
    // Menampilkan gambar dalam mode fullscreen
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          child: Image.network(
            laporan.imageUrl, // Default jika null
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  },
  child: Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      image: DecorationImage(
        image: NetworkImage(laporan.imageUrl), // Default jika null
        fit: BoxFit.cover,
      ),
    ),
  ),
),

                            title: Text(
                              laporan.keterangan,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Alamat: ${laporan.alamat}"),
                                Text("Pengirim: ${laporan.pengirim}"),
                                Text("Tanggal: ${laporan.tanggal.toLocal()}"),
                              ],
                            ),
                            onTap: () {
                              // ShowDialog untuk detail laporan
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("Detail Laporan"),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Nama Jalan: ${laporan.namaJalan}"),
                                        Text("Kelurahan: ${laporan.kelurahan}"),
                                        Text("Kecamatan: ${laporan.kecamatan}"),
                                        Text("Kota: ${laporan.kota}"),
                                        Text("Provinsi: ${laporan.provinsi}"),
                                        Text("Kode Pos: ${laporan.kodePos}"),
                                        Text("User ID: ${laporan.userId}"),
                                        Text("Role: ${laporan.role}"),
                                        Text("Keterangan: ${laporan.keterangan}"),
                                        Text(
                                            "Tanggal: ${laporan.tanggal.toLocal()}"),
                                        Text("Pengirim: ${laporan.pengirim}"),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Close"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
