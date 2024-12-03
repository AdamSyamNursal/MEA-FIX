class ModelPesan {
  final String idPesan;
  final String idUser;
  final String namaPengirim;
  final String pertanyaan;
  final String role;
  final DateTime timestamp;
  final String balasan;

  ModelPesan({
    required this.idPesan,
    required this.idUser,
    required this.namaPengirim,
    required this.pertanyaan,
    required this.role,
    required this.timestamp,
    required this.balasan
  });

  // Konversi objek ke Map untuk disimpan ke Firestore
  Map<String, dynamic> toJson() {
    return {
      'idPesan': idPesan,
      'idUser': idUser,
      'namaPengirim': namaPengirim,
      'pertanyaan': pertanyaan,
      'role': role,
      'timestamp': timestamp.toIso8601String(),
      'balasan' : balasan,
    };
  }

  // Factory untuk membuat objek dari Map (Firestore)
  factory ModelPesan.fromJson(Map<String, dynamic> json) {
    return ModelPesan(
      idPesan: json['idPesan'] ?? '',
      idUser: json['idUser'] ?? '',
      namaPengirim: json['namaPengirim'] ?? '',
      pertanyaan: json['pertanyaan'] ?? '',
      role: json['role'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      balasan: json['balasan'] ?? '',
    );
  }
}
