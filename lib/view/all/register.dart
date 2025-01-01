import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/widget/profilepage_login_register/register/registercontroller.dart';

class Register extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
    color: Colors.white, // Ganti warna ikon back sesuai kebutuhan
  ),
        backgroundColor: Color(0xFFFF6F00),
        title: Text(
          "Buat Akun Baru",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Color(0xFFFF6F00),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Form Container
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField(
                        controller: controller.nameController,
                        label: "Nama Lengkap",
                        hint: "Masukkan nama lengkap Anda",
                        validator: (value) =>
                            value!.isEmpty ? "Nama wajib diisi." : null,
                      ),
                      _buildInputField(
                        controller: controller.usernameController,
                        label: "Username",
                        hint: "Masukkan username Anda",
                        validator: (value) =>
                            value!.isEmpty ? "Username wajib diisi." : null,
                      ),
                      _buildInputField(
                        controller: controller.emailController,
                        label: "Email",
                        hint: "Masukkan email Anda",
                        validator: (value) {
                          if (value!.isEmpty) return "Email wajib diisi.";
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                            return "Format email tidak valid.";
                          return null;
                        },
                      ),
                      _buildInputField(
                        controller: controller.passwordController,
                        label: "Password",
                        hint: "Masukkan password",
                        obscureText: true,
                        validator: (value) =>
                            value!.isEmpty ? "Password wajib diisi." : null,
                      ),
                      _buildInputField(
                        controller: controller.confirmPasswordController,
                        label: "Konfirmasi Password",
                        hint: "Masukkan password yang sama",
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Konfirmasi password wajib diisi.";
                          if (value != controller.passwordController.text)
                            return "Password tidak cocok.";
                          return null;
                        },
                      ),
                      _buildInputField(
                        controller: controller.phoneNumberController,
                        label: "Nomor Telepon",
                        hint: "Masukkan nomor telepon Anda",
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? "Nomor telepon wajib diisi." : null,
                      ),
                      _buildInputField(
                        controller: controller.addressController,
                        label: "Alamat",
                        hint: "Masukkan alamat Anda",
                        validator: (value) =>
                            value!.isEmpty ? "Alamat wajib diisi." : null,
                      ),
                      _buildInputField(
                        controller: controller.dateOfBirthController,
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
                            Obx(
                              () => DropdownButtonFormField<String>(
                                value: controller.selectedRole.value,
                                items: ['Relawan', 'BPBD']
                                    .map((role) => DropdownMenuItem(
                                          value: role,
                                          child: Text(role),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  controller.selectedRole.value = value!;
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
                            onPressed: controller.registerUser,
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
