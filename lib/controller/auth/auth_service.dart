import 'dart:convert'; // Import untuk JSON parsing
import 'dart:developer'; // Import untuk logging
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> saveUser(Map<String, dynamic> user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Gunakan json.encode untuk menyimpan data sebagai JSON
      final userJson = json.encode(user);
      await prefs.setString('userData', userJson);
    } catch (e) {
      log("Error saving user data: $e", name: "AuthService"); // Menggunakan log
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('userData');
      if (userJson != null) {
        // Gunakan json.decode untuk membaca data dari JSON
        return Map<String, dynamic>.from(json.decode(userJson));
      }
    } catch (e) {
      log("Error getting user data: $e", name: "AuthService"); // Menggunakan log
    }
    return null;
  }

  Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData');
    } catch (e) {
      log("Error clearing user data: $e", name: "AuthService"); // Menggunakan log
    }
  }
}
