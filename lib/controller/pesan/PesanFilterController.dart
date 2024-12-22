import 'package:get/get.dart';

class PesanFilterController extends GetxController {
  var selectedBulan = ''.obs;
  var selectedTahun = ''.obs;

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

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    selectedBulan.value = bulanKeAngka.keys.firstWhere((key) => bulanKeAngka[key] == now.month);
    selectedTahun.value = now.year.toString();
  }

  int get bulanTerpilih => bulanKeAngka[selectedBulan.value]!;
  int get tahunTerpilih => int.parse(selectedTahun.value);
}
