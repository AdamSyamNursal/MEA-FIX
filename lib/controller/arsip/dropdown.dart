import 'package:flutter/material.dart';

class DropdownBulan extends StatefulWidget {
  @override
  _DropdownBulanState createState() => _DropdownBulanState();
}

class _DropdownBulanState extends State<DropdownBulan> {
  String _selectedBulan = 'Januari';
  final List<String> _bulanList = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedBulan,
      items: _bulanList.map((String bulan) {
        return DropdownMenuItem<String>(
          value: bulan,
          child: Text(bulan),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedBulan = newValue!;
        });
      },
    );
  }
}

class DropdownTahun extends StatefulWidget {
  @override
  _DropdownTahunState createState() => _DropdownTahunState();
}

class _DropdownTahunState extends State<DropdownTahun> {
  String _selectedTahun = '2024';
  final List<String> _tahunList = ['2024', '2025', '2026'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedTahun,
      items: _tahunList.map((String tahun) {
        return DropdownMenuItem<String>(
          value: tahun,
          child: Text(tahun),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedTahun = newValue!;
        });
      },
    );
  }
}