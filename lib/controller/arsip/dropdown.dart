import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownBulan extends StatelessWidget {
  final PesanFilterController controller = Get.find();

  DropdownBulan({super.key}); 

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

  DropdownTahun({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton<String>(
        value: controller.selectedTahun.value,
        items: ['2024', '2025', '2026'].map((String tahun) {
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

class PesanFilterController extends GetxController {
  var selectedBulan = 'Januari'.obs;
  var selectedTahun = '2024'.obs;

  // Map bulan ke angka untuk filtering
  final Map<String, int> bulanKeAngka = {
    'Januari': 1,
    'Februari': 2,
    'Maret': 3,
    'April': 4,
    'Mei': 5,
    'Juni': 6,
    'Juli': 7,
    'Agustus': 8,
    'September': 9,
    'Oktober': 10,
    'November': 11,
    'Desember': 12,
  };

  int get bulanTerpilih => bulanKeAngka[selectedBulan.value]!;
  int get tahunTerpilih => int.parse(selectedTahun.value);
}
