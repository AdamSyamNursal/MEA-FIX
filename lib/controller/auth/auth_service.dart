import 'dart:convert'; // Import untuk JSON parsing
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> saveUser(Map<String, dynamic> user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Gunakan json.encode untuk menyimpan data sebagai JSON
      final userJson = json.encode(user);
      await prefs.setString('userData', userJson);
    } catch (e) {
      print("Error saving user data: $e");
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
      print("Error getting user data: $e");
    }
    return null;
  }

  Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData');
    } catch (e) {
      print("Error clearing user data: $e");
    }
  }
}
