import 'package:cloud_firestore/cloud_firestore.dart';

class Laporan {
  final String id; // ID dokumen Firestore
  final String namaJalan;
  final String kelurahan;
  final String kecamatan;
  final String kota;
  final String provinsi;
  final String kodePos;
  final String userId; // ID pengguna yang membuat laporan
  final String role; // Role pengguna
  final String alamat;
  final String keterangan;
  final DateTime tanggal;
  final bool valid;
  final String pengirim;
  final String? imageUrl; // Tambahkan properti untuk URL gambar (opsional)
  final double? longitude; // Tambahkan properti longitude
  final double? latitude;  // Tambahkan properti latitude
  final bool arsip;

  Laporan({
    required this.id,
    required this.namaJalan,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.kodePos,
    required this.userId,
    required this.role,
    required this.alamat,
    required this.keterangan,
    required this.tanggal,
    required this.valid,
    required this.pengirim,
    this.imageUrl, // URL gambar opsional
    this.latitude,
    this.longitude,
    required this.arsip,
  });

  // Factory untuk membuat objek dari Map (Firestore)
  factory Laporan.fromJson(String id, Map<String, dynamic> json) {
    return Laporan(
      id: id,
      namaJalan: json['nama_jalan'] ?? '',
      kelurahan: json['kelurahan'] ?? '',
      kecamatan: json['kecamatan'] ?? '',
      kota: json['kota'] ?? '',
      provinsi: json['provinsi'] ?? '',
      kodePos: json['kode_pos'] ?? '',
      userId: json['user_id'] ?? '',
      role: json['role'] ?? '',
      alamat: json['alamat'] ?? '',
      keterangan: json['keterangan'] ?? '',
      tanggal: (json['tanggal'] as Timestamp).toDate(),
      valid: json['valid'] ?? false,
      pengirim: json['pengirim'] ?? '',
      imageUrl: json['imageUrl'], // Ambil URL gambar jika tersedia
      latitude: json['latitude'],
      longitude: json['longtitude'],
      arsip: json['arsip'] ?? false,
    );
  }

  // Method untuk mengubah objek menjadi Map (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'nama_jalan': namaJalan,
      'kelurahan': kelurahan,
      'kecamatan': kecamatan,
      'kota': kota,
      'provinsi': provinsi,
      'kode_pos': kodePos,
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
