import 'dart:convert';
import 'dart:developer'; // Untuk logging
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mea/view/all/login.dart';
import 'package:mea/view/all/profile.dart';

class AuthController extends GetxController {
  // Status login (RxBool)
  var isLoggedIn = false.obs;

  // Data pengguna (RxMap)
  var userData = <String, dynamic>{}.obs;

  // Getters untuk mengambil informasi pengguna
  String get userId => userData['id'] ?? '';
  String get role => userData['role'] ?? '';
  bool get acc => userData['acc'] ?? false;

  /// Mengecek status login dari SharedPreferences
  Future<void> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('userData');

      if (userJson != null) {
        // Decode JSON ke Map dan simpan di userData
        userData.value = Map<String, dynamic>.from(json.decode(userJson));
        isLoggedIn.value = true; // Set status login
      } else {
        isLoggedIn.value = false; // Tidak ada data
      }
    } catch (e) {
      log("Error checking login status: $e"); // Menggunakan log
      isLoggedIn.value = false; // Default ke tidak login
    }
  }

  /// Login pengguna dengan data user (disimpan di SharedPreferences)
  Future<void> loginUser(Map<String, dynamic> user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Simpan data user dalam bentuk JSON
      await prefs.setString('userData', json.encode(user));
      userData.value = user; // Set data pengguna
      isLoggedIn.value = true; // Set status login

      // Navigasi ke halaman ProfilePage berdasarkan userId
      Get.off(() => ProfilePage(userid: userId));
    } catch (e) {
      log("Error during login: $e"); // Menggunakan log
    }
  }

  /// Logout pengguna dan hapus data dari SharedPreferences
  Future<void> logoutUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData'); // Hapus data pengguna
      userData.value = {}; // Reset data pengguna
      isLoggedIn.value = false; // Set status logout

      // Navigasi ke halaman login
      Get.offAll(() => Login());
    } catch (e) {
      log("Error during logout: $e"); // Menggunakan log
    }
  }
}
