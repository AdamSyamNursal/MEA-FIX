// File: lib/controller/dropdown/kabupaten_dropdown.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KabupatenDropdown extends StatelessWidget {
  final Map<String, List<String>> kabupatenKecamatanSumbar;
  final RxString selectedKabupaten;
  final RxString selectedKecamatan;

  KabupatenDropdown({
    required this.kabupatenKecamatanSumbar,
    required this.selectedKabupaten,
    required this.selectedKecamatan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kabupaten",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6F00),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => DropdownButtonFormField<String>(
              value: selectedKabupaten.value.isEmpty
                  ? null
                  : selectedKabupaten.value,
              hint: Text("Pilih Kabupaten"),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                selectedKabupaten.value = value ?? "";
                selectedKecamatan.value = "";
              },
              items: kabupatenKecamatanSumbar.keys.map((kabupaten) {
                return DropdownMenuItem<String>(
                  value: kabupaten,
                  child: Text(kabupaten),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Kecamatan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6F00),
            ),
          ),
          SizedBox(height: 10),
          Obx(
            () => DropdownButtonFormField<String>(
              value: selectedKecamatan.value.isEmpty
                  ? null
                  : selectedKecamatan.value,
              hint: Text("Pilih Kecamatan"),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                selectedKecamatan.value = value ?? "";
              },
              items: kabupatenKecamatanSumbar[selectedKabupaten.value]?.map((kecamatan) {
                return DropdownMenuItem<String>(
                  value: kecamatan,
                  child: Text(kecamatan),
                );
              }).toList() ?? [],
            ),
          ),
        ],
      ),
    );
  }
}
