import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mea/model/modelpesan.dart';

class DetailPesan extends StatefulWidget {
  final ModelPesan pesan;
  final String role;

  DetailPesan({required this.pesan, required this.role});

  @override
  _DetailPesanState createState() => _DetailPesanState();
}

class _DetailPesanState extends State<DetailPesan> {
  final TextEditingController replyController = TextEditingController();
  String currentBalasan = ""; // Untuk menampilkan balasan terbaru

  @override
  void initState() {
    super.initState();
    // Ambil balasan terkini dari Firebase
    currentBalasan = widget.pesan.balasan;
  }

  Future<void> kirimBalasan(String replyText) async {
    await FirebaseFirestore.instance
        .collection('pesan')
        .doc(widget.pesan.idPesan)
        .update({'balasan': replyText});

    // Update tampilan dengan balasan terbaru
    setState(() {
      currentBalasan = replyText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan warna dan ikon berdasarkan role
    final Color roleColor = (widget.pesan.role == 'Relawan')
        ? Colors.green
        : (widget.pesan.role == 'user')
            ? Colors.red
            : Colors.grey;
    final String roleIcon = (widget.pesan.role == 'Relawan')
        ? 'assets/icons/relawan.png'
        : (widget.pesan.role == 'user')
            ? 'assets/icons/masyarakat.png'
            : 'assets/icons/default.png';

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pesan", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFFF6F00),
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
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pesan.namaPengirim,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: roleColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Role: ${widget.pesan.role}",
                        style: TextStyle(fontSize: 14, color: roleColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Pertanyaan dan tanggal dalam satu box
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFF6F00),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: roleColor, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pertanyaan:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.pesan.pertanyaan,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Tanggal: ${widget.pesan.timestamp.day}/${widget.pesan.timestamp.month}/${widget.pesan.timestamp.year}",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Bagian Balasan
            Text(
              "Balasan:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFFF6F00), width: 1.5),
              ),
              child: Text(
                currentBalasan.isNotEmpty
                    ? currentBalasan
                    : "Belum ada balasan.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 20),

            // Jika role adalah BPBD, tampilkan box untuk menambahkan balasan
            if (widget.role == 'BPBD') ...[
              Text(
                "Tambahkan Balasan:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: replyController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Tulis balasan Anda...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        final replyText = replyController.text.trim();
                        if (replyText.isNotEmpty) {
                          await kirimBalasan(replyText);

                          // Tampilkan Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Balasan berhasil dikirim!"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Kosongkan TextField
                          replyController.clear();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6F00),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
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
