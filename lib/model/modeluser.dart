class UserModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String password; // Tambahkan properti password
  final String role;
  final String phoneNumber;
  final String address;
  final String dateOfBirth;
  final String registrationDate;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password, // Tambahkan di sini
    required this.role,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.registrationDate,
  });

  // Mapping dari JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '', // Tambahkan password
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      registrationDate: json['registrationDate'] ?? '',
    );
  }

  // Mapping ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name': name,
      'username': username,
      'email': email,
      'password': password, // Tambahkan password
      'role': role,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'registrationDate': registrationDate,
    };
  }
}
