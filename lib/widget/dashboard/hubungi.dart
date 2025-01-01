import 'package:flutter/material.dart';
import 'package:mea/view/all/dashboar.dart';

class Hubungi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFF6F00),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // App Bar Section
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => dashboard(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Content Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Kontak BPBD",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Alamat: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Jl. Raya Batusangkar No.465, Limo Kaum, Kec. Lima Kaum, Kabupaten Tanah Datar, Sumatera Barat 27213",
                                ),
                              ],
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      // Jam Aktivitas Section
                      Column(
                        children: [
                          const Text(
                            "Jam Aktivitas",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                _ActivityRow(day: "Senin", time: "07.30–16.00"),
                                Divider(color: Colors.grey),
                                _ActivityRow(day: "Selasa", time: "07.30–16.00"),
                                Divider(color: Colors.grey),
                                _ActivityRow(day: "Rabu", time: "07.30–16.00"),
                                Divider(color: Colors.grey),
                                _ActivityRow(day: "Kamis", time: "07.30–16.00"),
                                Divider(color: Colors.grey),
                                _ActivityRow(day: "Jumat", time: "07.30–16.30"),
                                Divider(color: Colors.grey),
                                _ActivityRow(day: "Sabtu", time: "Tutup"),
                                Divider(color: Colors.grey),
                                _ActivityRow(day: "Minggu", time: "Tutup"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Instagram Section
                          const Text(
                            "Bisa DM pada IG",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              // Tambahkan logika untuk membuka Instagram jika diperlukan
                            },
                            child: const Text(
                              "@bpbd_tanah_datar",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Logo Section
                      Image.asset(
                        'assets/images/BPBD.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk setiap baris aktivitas
class _ActivityRow extends StatelessWidget {
  final String day;
  final String time;

  const _ActivityRow({
    required this.day,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          time,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
