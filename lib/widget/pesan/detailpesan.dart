import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/model/modelpesan.dart';

class DetailPesan extends GetView<DetailPesanController> {
  final ModelPesan pesan;
  final String role;

  DetailPesan({required this.pesan, required this.role});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailPesanController(pesan));

    // Menentukan warna dan ikon berdasarkan role
    final Color roleColor = (pesan.role == 'Relawan')
        ? Colors.green
        : (pesan.role == 'user')
            ? Colors.red
            : Colors.grey;
    final String roleIcon = (pesan.role == 'Relawan')
        ? 'assets/icons/relawan.png'
        : (pesan.role == 'user')
            ? 'assets/icons/masyarakat.png'
            : 'assets/icons/default.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Pesan",
          style: TextStyle(color: Colors.white),
        ),
          iconTheme: IconThemeData(
    color: Colors.white, // Ganti warna ikon back sesuai kebutuhan
  ),
        backgroundColor: const Color(0xFFFF6F00),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan ikon dan nama pengirim
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: roleColor.withOpacity(0.2),
                  child: Image.asset(
                    roleIcon,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pesan.namaPengirim,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: roleColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Role: ${pesan.role}",
                        style: TextStyle(fontSize: 14, color: roleColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pertanyaan dan tanggal dalam satu box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6F00),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: roleColor, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pertanyaan:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pesan.pertanyaan,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Tanggal: ${pesan.timestamp.day}/${pesan.timestamp.month}/${pesan.timestamp.year}",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bagian Balasan
            const Text(
              "Balasan:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(() => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFF6F00), width: 1.5),
                  ),
                  child: Text(
                    controller.currentBalasan.isNotEmpty
                        ? controller.currentBalasan.value
                        : "Belum ada balasan.",
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
            const SizedBox(height: 20),

            // Jika role adalah BPBD, tampilkan box untuk menambahkan balasan
            if (role == 'BPBD') ...[
              const Text(
                "Tambahkan Balasan:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.replyController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: "Tulis balasan Anda...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        final replyText = controller.replyController.text.trim();
                        if (replyText.isNotEmpty) {
                          await controller.kirimBalasan(replyText);

                          // Tampilkan Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Balasan berhasil dikirim!"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Kosongkan TextField
                          controller.replyController.clear();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6F00),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class DetailPesanController extends GetxController {
  final ModelPesan pesan;
  DetailPesanController(this.pesan);

  final TextEditingController replyController = TextEditingController();
  final RxString currentBalasan = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentBalasan.value = pesan.balasan;
  }

  Future<void> kirimBalasan(String replyText) async {
    await FirebaseFirestore.instance
        .collection('pesan')
        .doc(pesan.idPesan)
        .update({'balasan': replyText});

    currentBalasan.value = replyText;
  }
}
