import 'package:cloud_firestore/cloud_firestore.dart';

class Laporan {
  final String id; // ID dokumen Firestore
  final String namaJalan;
  final String jorong;
  final String kecamatan;
  final String kabupaten;
  final String userId; // ID pengguna yang membuat laporan
  final String role; // Role pengguna
  final String alamat;
  final String keterangan;
  final DateTime tanggal;
  final bool valid;
  final String pengirim;
  final String imageUrl; // Tambahkan properti untuk URL gambar (opsional)
  final double? longitude; // Tambahkan properti longitude
  final double? latitude;  // Tambahkan properti latitude
  final bool arsip;

  Laporan({
    required this.id,
    required this.namaJalan,
    required this.jorong,
    required this.kecamatan,
    required this.kabupaten,
    required this.userId,
    required this.role,
    required this.alamat,
    required this.keterangan,
    required this.tanggal,
    required this.valid,
    required this.pengirim,
    required this.imageUrl, // URL gambar opsional
    this.latitude,
    this.longitude,
    required this.arsip,
  });

  // Factory untuk membuat objek dari Map (Firestore)
  factory Laporan.fromJson(String id, Map<String, dynamic> json) {
    return Laporan(
      id: id,
      namaJalan: json['nama_jalan'] ?? '',
      jorong: json['jorong'] ?? '',
      kecamatan: json['kecamatan'] ?? '',
      kabupaten: json['kabupaten'] ?? '',
      userId: json['user_id'] ?? '',
      role: json['role'] ?? '',
      alamat: json['alamat'] ?? '',
      keterangan: json['keterangan'] ?? '',
      tanggal: (json['tanggal'] as Timestamp).toDate(),
      valid: json['valid'] ?? false,
      pengirim: json['pengirim'] ?? '',
latitude: json['latitude'] ?? 0.0,
longitude: json['longtitude'] ?? 0.0,
imageUrl: json['imageUrl'] ?? '',
      arsip: json['arsip'] ?? false,
    );
  }

  // Method untuk mengubah objek menjadi Map (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'nama_jalan': namaJalan,
      'jorong': jorong,
      'kecamatan': kecamatan,
      'kabupaten' : kabupaten,
      'user_id': userId,
      'role': role,
      'alamat': alamat,
      'keterangan': keterangan,
      'tanggal': tanggal,
      'valid': valid,
      'pengirim': pengirim,
      'imageUrl': imageUrl, // Tambahkan URL gambar jika ada
      'latitude' : latitude,
      'longtitude' : longitude,
      'arsip' : arsip,
    };
  }
}
