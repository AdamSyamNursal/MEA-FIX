import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mea/view/all/profile.dart';


class EditProfilePage extends StatelessWidget {
  final String userid;

  EditProfilePage({required this.userid});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color(0xFFFF6F00),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(userid).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
        
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(
                  child: Text("User data not found"),
                );
              }
        
              final userData = snapshot.data!.data() as Map<String, dynamic>;
        
              nameController.text = userData['name'] ?? '';
              usernameController.text = userData['username'] ?? '';
              emailController.text = userData['email'] ?? '';
              phoneController.text = userData['phoneNumber'] ?? '';
              addressController.text = userData['address'] ?? '';
              dobController.text = userData['dateOfBirth'] ?? '';
        
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Nomor Telepon",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: "Tanggal Lahir (YYYY-MM-DD)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userid)
                              .update({
                            'name': nameController.text.trim(),
                            'username': usernameController.text.trim(),
                            'email': emailController.text.trim(),
                            'phoneNumber': phoneController.text.trim(),
                            'address': addressController.text.trim(),
                            'dateOfBirth': dobController.text.trim(),
                          });
        
                          Get.snackbar("Success", "Profile updated successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
        
                          Get.off(() => ProfilePage(userid: userid)); // Navigasi kembali ke ProfilePage
                        } catch (e) {
                          Get.snackbar("Error", "Failed to update profile: ${e.toString()}",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
                      },
                      child: Text("Save Changes"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6F00),
                        minimumSize: Size(200, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
