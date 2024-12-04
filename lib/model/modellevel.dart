class Level {
  final int level;

  Level({required this.level});

  // Convert JSON from Firestore to Level model
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      level: json['level'] ?? 1,
    );
  }

  // Convert Level model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'level': level,
    };
  }
}
