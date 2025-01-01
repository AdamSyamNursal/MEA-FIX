import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mea/widget/dashboard/rekomendasi_button/rekomendasi_akun/rekomendasi_text.dart';
import 'package:mea/view/all/dashboar.dart';
import 'package:mea/widget/dashboard/rekomendasi_button/rekomendasi_akun/editrekomendasi.dart';
import 'package:intl/intl.dart';

class Rekomendasi extends StatelessWidget {
  final String role;
  final bool acc;

  Rekomendasi({required this.role, required this.acc});

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFF6F00),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('recommendations')
              .orderBy('timestamp', descending: true)
              .limit(1)
              .get()
              .then((snapshot) => snapshot.docs.first),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Error loading recommendations",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(
                child: Text("No recommendations available"),
              );
            }

            // Retrieve the timestamp from Firebase
            Timestamp timestamp = snapshot.data!.get('timestamp');

            return Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => dashboard()),
                        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      ),
                      const Text(
                        "Rekomendasi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      if (role == "BPBD" && acc)
                        GestureDetector(
                          onTap: () => Get.to(() => ViewEdit()),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                color: Color(0xFFFF6F00),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          Text(
                            formatDate(timestamp),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            "assets/images/BPBD.png",
                            height: 80,
                            width: 80,
                          ),
                          const SizedBox(height: 20),
                          RekomendasiText(), // Menggunakan widget RekomendasiText
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
