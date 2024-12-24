import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/widget/dashboard/rekomendasi_akun/akun.dart';
import 'package:mea/view/all/laporan.dart';
import 'package:mea/view/all/rekomendasi.dart';

class Popupmenubutton extends StatelessWidget {
  final AuthController authController;

  Popupmenubutton({required this.authController});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == "Rekomendasi") {
                    Get.to(() => Rekomendasi(
                          role: authController.role,
                          acc: authController.acc,
                        ));
                  }
                  if (value == "Laporan") {
                    Get.to(() => ViewLaporan());
                  }
                  if (value == "Akun") {
                    Get.to(() => UserListView());
                  }
                },
                itemBuilder: (BuildContext context) {
                  if (authController.role == "BPBD" && authController.acc) {
                    return [
                      PopupMenuItem(
                        value: "Laporan",
                        child: Text("Laporan"),
                      ),
                      PopupMenuItem(
                        value: "Akun",
                        child: Text("Akun"),
                      ),
                      PopupMenuItem(
                        value: "Rekomendasi",
                        child: Text("Rekomendasi"),
                      ),
                    ];
                  } else {
                    return [
                      PopupMenuItem(
                        value: "Rekomendasi",
                        child: Text("Rekomendasi"),
                      ),
                    ];
                  }
                },
              );
  }
}