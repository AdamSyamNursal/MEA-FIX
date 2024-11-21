import 'package:flutter/material.dart';

class LaporanAktivitas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 56),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
Container(
  height: 27,
  width: 27,
  child: GestureDetector(
    onTap: () {
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    },
    child: Icon(
      Icons.keyboard_backspace_rounded,
      color: Colors.white,
    ),
  ),
),

                    Container(
                      child: Center(
                        child: Text(
                          "Laporan Aktivitas",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
                        SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Periode Pengamatan",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    Text("16-04-2024"),
                                    Text("06:00 - 12:00 WIB"),
                                  ],
                                ),
                              ),
                              Container(
                                height: 24,
                                width: 24,
                                child: Image.asset('assets/icons/edit.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          child: Column(
                            children: [
                              KolumLaporan(judul: "Meteorologist"),
                              SizedBox(height: 18), // Add spacing between sections
                              KolumLaporan(judul: "Visual"),
                              SizedBox(height: 18),
                              KolumLaporan(judul: "Kegempaan"),
                              SizedBox(height: 18),
                              KolumLaporan(judul: "Keterangan"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KolumLaporan extends StatelessWidget {
  final String judul;

  KolumLaporan({required this.judul});

  Map<String, String> status() {
    String gambar = '';
    String deskripsi = '';

    if (judul == "Meteorologist") {
      gambar = "assets/icons/meterologi.png";
      deskripsi = "Cuaca berawan. Angin bertiup lemah ke arah timur dan barat laut. Suhu udara 21.1-28.3 °C, kelembaban udara 60.5-84.3 %, dan tekanan udara 681.8-681.9 mmHg";
    } else if (judul == "Visual") {
      gambar = "assets/icons/eye.png";
      deskripsi = "Gunung jelas hingga kabut 0-III. Asap kawah bertekanan lemah teramati berwarna putih dengan intensitas sedang dan tinggi 300 m di atas puncak kawah.";
    } else if (judul == "Kegempaan") {
      gambar = "assets/icons/frekuensi.png";
      deskripsi = "Hembusan \n (Jumlah : 1, Amplitudo : 2 mm, Durasi : 20 detik) \n\n Tektonik Lokal \n (Jumlah : 1, Amplitudo : 1.7 mm, S-P : 9.3 detik, Durasi : 54 detik) \n\n Tektonik Jauh \n (Jumlah : 1, Amplitudo : 2.9 mm, S-P : 18 detik, Durasi : 40 detik) \n\n Tremor Menerus (Microtremor) terekam dengan amplitudo 0.5-1.5 mm (dominan 1 mm)";
    } else if (judul == "Keterangan") {
      gambar = "assets/icons/eye.png";
      deskripsi = "";
    }

    return {'gambar': gambar, 'deskripsi': deskripsi};
  }

  @override
  Widget build(BuildContext context) {
  var statusInfo = status();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 17.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Shadow color
          blurRadius: 10, // Spread of the shadow
          offset: Offset(0, 4), // Position of the shadow (horizontal, vertical)
        ),
      ],
    ),
    child: Row(
      children: [
        // Menampilkan gambar berdasarkan statusInfo
        Container(
          height: 50,
          width: 50,
          child: Image.asset(statusInfo['gambar']!),
        ),
        SizedBox(width: 10), // Space between the icon and text
        // Menampilkan deskripsi berdasarkan statusInfo
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(statusInfo['deskripsi']!),
            ],
          ),
        ),
      ],
    ),
  );
}
}
