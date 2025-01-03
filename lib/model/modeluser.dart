class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String role;
  final String phoneNumber;
  final String address;
  final String dateOfBirth;
  final String registrationDate;
  final bool acc;

  UserModel({
    required this.id, // Tambahkan di sini
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.registrationDate,
    required this.acc,
  });

  // Mapping dari JSON
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id, // Tetapkan id di sini
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      registrationDate: json['registrationDate'] ?? '',
      acc: json['acc'] ?? false,
    );
  }

  // Mapping ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'registrationDate': registrationDate,
      'acc': acc,
    };
  }
}
