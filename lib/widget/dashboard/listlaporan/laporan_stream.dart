import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/widget/dashboard/listlaporan/kosong.dart';
import 'package:mea/widget/dashboard/listlaporan/listlaporan.dart';

class ReportListStream extends StatelessWidget {
  final AuthController authController;

  ReportListStream({required this.authController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('laporan')
          .where('arsip', isEqualTo: false)
          .orderBy('tanggal', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Kosong(
            isilist: false,
            content: Container(),
          );
        }

        final laporanList = snapshot.data!.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        return Kosong(
          isilist: true,
          content: listlaporan(
            laporanList: laporanList,
            acc: authController.acc,
            akses: authController.role,
          ),
        );
      },
    );
  }
}