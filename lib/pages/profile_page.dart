import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login_page.dart';

class ProfilePage extends GetView<AuthController> {
  const ProfilePage({super.key});

  final String kesan = 'Praktikum mobile seru dan asik BANGETTTT!';
  final String pesan = 'Semangat terus untuk asisten praktikum';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: Colors.grey[850],
              child: const Icon(Icons.person, size: 46),
            ),
            const SizedBox(height: 16),

            // Username dari SharedPreferences (Obx karena nilainya reaktif)
            Obx(
              () => Text(
                controller.username.value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14),

            Text(
              'Kesan: $kesan',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              'Pesan: $pesan',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.logout(); // hapus session
                  Get.offAll(() => const LoginPage()); // kembali ke login
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
