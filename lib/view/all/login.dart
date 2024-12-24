import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mea/controller/auth/auth_controller.dart';
import 'package:mea/widget/profilepage_login_register/forgetpassword.dart';
import 'package:mea/view/all/register.dart';
import 'package:mea/view/navigation_bar.dart';
import 'package:mea/widget/profilepage_login_register/login/logincontroller.dart'; // Untuk utf8.encode



class Login extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFF6F00),
        body: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 27),
                ],
              ),
            ),

            // White Container
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Login Image
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/images/loginimage.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Username Field
                      TextField(
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          hintText: "Nama/Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Password Field

                      Column(
                        children: [
                          Obx(() => TextField(
                                controller: controller.passwordController,
                                obscureText: controller.obscureText.value,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscureText.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: controller.togglePasswordVisibility,
                                  ),
                                ),
                              )),
                          
                          Align(
                            alignment: Alignment.topLeft,
                            child: 
                            TextButton(onPressed: (){
                              Get.to(() => ForgotPasswordView());
                            }, child: Text("Lupa Password")),
                          )
                        ],
                      ),
                      SizedBox(height: 30),

                      // Login Button
                      ElevatedButton(
                        onPressed: controller.loginUser,
                        child: Text(
                          "Masuk",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6F00),
                          minimumSize: Size(300, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Register Button
                      OutlinedButton(
                        onPressed: () {
                          Get.to(() => Register());
                        },
                        child: Text(
                          "Daftar",
                          style: TextStyle(color: Color(0xFFFF6F00)),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(300, 45),
                          side: BorderSide(color: Color(0xFFFF6F00)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          authController: Get.find<AuthController>(),
          currentIndex: 3, // Tab pertama untuk Login
        ),
      ),
    );
  }
}
