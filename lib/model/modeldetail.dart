class Detail {
  final String meteorologist;
  final String visual;
  final String kegempaan;
  final String keterangan;
  final String timestampTanggal;
  final String timestampJam;

  Detail({
    required this.meteorologist,
    required this.visual,
    required this.kegempaan,
    required this.keterangan,
    required this.timestampTanggal,
    required this.timestampJam,
  });

  // Convert JSON to Model
  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(

      meteorologist: json['meteorologist'] ?? '',
      visual: json['visual'] ?? '',
      kegempaan: json['kegempaan'] ?? '',
      keterangan: json['keterangan'] ?? '',
      timestampTanggal: json['timestampTanggal'] ?? '',
      timestampJam: json['timestampJam'] ?? '',
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'meteorologist': meteorologist,
      'visual': visual,
      'kegempaan': kegempaan,
      'keterangan': keterangan,
      'timestampTanggal': timestampTanggal,
      'timestampJam': timestampJam,
    };
  }
}
