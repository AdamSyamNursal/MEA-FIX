import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/pesan/PesanFilterController.dart';

class DropdownBulan extends StatelessWidget {
  final PesanFilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton<String>(
        value: controller.selectedBulan.value,
        items: controller.bulanKeAngka.keys.map((String bulan) {
          return DropdownMenuItem<String>(
            value: bulan,
            child: Text(bulan),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.selectedBulan.value = newValue;
          }
        },
      ),
    );
  }
}

class DropdownTahun extends StatelessWidget {
  final PesanFilterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton<String>(
        value: controller.selectedTahun.value,
        items: [for (int i = 2020; i <= DateTime.now().year + 1; i++) i.toString()].map((String tahun) {
          return DropdownMenuItem<String>(
            value: tahun,
            child: Text(tahun),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.selectedTahun.value = newValue;
          }
        },
      ),
    );
  }
}

