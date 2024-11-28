import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/view/all/profile.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs; // Status login
  var userData = <String, dynamic>{}.obs; // Data pengguna sebagai RxMap

  String get userId => userData['id'] ?? '';
  String get role => userData['role'] ?? '';
  

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userData');
    if (userJson != null) {
      try {
        userData.value = Map<String, dynamic>.from(json.decode(userJson)); // Decode JSON
        isLoggedIn.value = true;
      } catch (e) {
        print("Error decoding user data: $e");
        isLoggedIn.value = false;
      }
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<void> loginUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', json.encode(user)); // Simpan data sebagai JSON
    userData.value = user;
    isLoggedIn.value = true;
    Get.off(() => ProfilePage(userData: userData.value)); // Navigasi ke profil
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData'); // Hapus data
    userData.value = {};
    isLoggedIn.value = false;
    Get.offAll(() => Login()); // Navigasi ke login
  }
}
