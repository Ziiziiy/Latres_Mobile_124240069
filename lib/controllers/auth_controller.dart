// auth_controller.dart -> CONTROLLER untuk login & logout
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final String nim = '124240069';
  final String password = '123';

  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  final username = ''.obs;

  @override
  void onInit() {
    loadUsername();
    super.onInit();
  }

  // Ambil username yang tersimpan di SharedPreferences
  void loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'Guest';
  }

    Future<bool> login() async {
    final inputUsername = usernameC.text.trim();
    final inputPassword = passwordC.text.trim();

    if (inputUsername == nim && inputPassword == password) {
      // Simpan informasi login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', inputUsername);

      username.value = inputUsername;
      usernameC.clear();
      passwordC.clear();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    username.value = '';
  }
}
