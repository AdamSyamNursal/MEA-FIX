import 'package:flutter/material.dart';
import 'package:mea/controller/list/sub/lokasigambar.dart';
import 'package:mea/controller/list/sub/rolepengirim.dart';

class gambarstack extends StatelessWidget {
  final String? gambar; // Mengizinkan nilai null
  final String role;
  final bool acc;

  gambarstack({required this.role, required this.acc, this.gambar});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        gambar == null || gambar!.isEmpty
            ? Image.asset(
                'assets/images/contoh.png',
                width: 330,
                height: 200,
                fit: BoxFit.cover,
              )
            : Image.network(
                gambar!,
                width: 330,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/contoh.png', // Jika gambar gagal dimuat, tampilkan gambar default
                    width: 330,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                },
              ),
        lokasigambar(),
        rolepengirim(
          role: role,
          acc: acc, // Pastikan parameter acc dikirim ke RolePengirim
        ),
      ],
    );
  }
}
