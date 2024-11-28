import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/model/modeluser.dart';
import 'package:mea/view/all/login.dart'; // Pastikan path benar

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  String _selectedRole = 'Relawan'; // Default role
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Extract form values
      final name = _nameController.text.trim();
      final username = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final phoneNumber = _phoneNumberController.text.trim();
      final address = _addressController.text.trim();
      final dateOfBirth = _dateOfBirthController.text.trim();
      final role = _selectedRole;

      // Save user data to Firestore
      final user = UserModel(
        name: name,
        username: username,
        email: email,
        password: password,
        role: role,
        phoneNumber: phoneNumber,
        address: address,
        dateOfBirth: dateOfBirth,
        registrationDate: DateTime.now().toIso8601String(),
      );

      await _firestore.collection('users').add(user.toJson());

      // Notifikasi sukses menggunakan Get.snackbar
      Get.snackbar(
        "Sukses",
        "Registrasi berhasil!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigasi ke Login menggunakan GetX
      Get.offAll(() => Login());
    } catch (e) {
      // Notifikasi error menggunakan Get.snackbar
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6F00),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(), // Mengganti Navigator.pop
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form Container
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        "Buat Akun Baru",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFFFF6F00),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Name Field
                      _buildInputField(
                        controller: _nameController,
                        label: "Nama Lengkap",
                        hint: "Masukkan nama lengkap Anda",
                        validator: (value) =>
                            value!.isEmpty ? "Nama wajib diisi." : null,
                      ),

                      // Username Field
                      _buildInputField(
                        controller: _usernameController,
                        label: "Username",
                        hint: "Masukkan username Anda",
                        validator: (value) =>
                            value!.isEmpty ? "Username wajib diisi." : null,
                      ),

                      // Email Field
                      _buildInputField(
                        controller: _emailController,
                        label: "Email",
                        hint: "Masukkan email Anda",
                        validator: (value) {
                          if (value!.isEmpty) return "Email wajib diisi.";
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                            return "Format email tidak valid.";
                          return null;
                        },
                      ),

                      // Password Field
                      _buildInputField(
                        controller: _passwordController,
                        label: "Password",
                        hint: "Masukkan password",
                        obscureText: true,
                        validator: (value) =>
                            value!.isEmpty ? "Password wajib diisi." : null,
                      ),

                      // Confirm Password Field
                      _buildInputField(
                        controller: _confirmPasswordController,
                        label: "Konfirmasi Password",
                        hint: "Masukkan password yang sama",
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Konfirmasi password wajib diisi.";
                          if (value != _passwordController.text)
                            return "Password tidak cocok.";
                          return null;
                        },
                      ),

                      // Phone Number Field
                      _buildInputField(
                        controller: _phoneNumberController,
                        label: "Nomor Telepon",
                        hint: "Masukkan nomor telepon Anda",
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? "Nomor telepon wajib diisi." : null,
                      ),

                      // Address Field
                      _buildInputField(
                        controller: _addressController,
                        label: "Alamat",
                        hint: "Masukkan alamat Anda",
                        validator: (value) =>
                            value!.isEmpty ? "Alamat wajib diisi." : null,
                      ),

                      // Date of Birth Field
                      _buildInputField(
                        controller: _dateOfBirthController,
                        label: "Tanggal Lahir",
                        hint: "Masukkan tanggal lahir Anda (dd-mm-yyyy)",
                        keyboardType: TextInputType.datetime,
                        validator: (value) =>
                            value!.isEmpty ? "Tanggal lahir wajib diisi." : null,
                      ),

                      // Role Dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Role",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFFFF6F00),
                              ),
                            ),
                            SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: _selectedRole,
                              items: ['Relawan', 'BPBD']
                                  .map((role) => DropdownMenuItem(
                                        value: role,
                                        child: Text(role),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? "Role wajib dipilih."
                                      : null,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      // Register Button
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: _registerUser,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Color(0xFFFF6F00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Daftar",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFFFF6F00),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
