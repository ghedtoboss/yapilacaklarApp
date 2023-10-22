import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/pages/home_screen.dart';
import 'package:yapilcaklar/pages/login_screen.dart';
import 'package:yapilcaklar/service/auth_service.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final authServiceController = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    // Uygulama açıldığında otomatik giriş kontrolü
    Future.microtask(() {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Kullanıcı giriş yapmış, doğrudan ana sayfaya yönlendir
        authServiceController.userId.value = currentUser.uid;
        Get.off(
            HomeScreen()); // 'Get.off' ana sayfaya gitmeyi ve geçmişi temizlemeyi sağlar
      } else {
        // Kullanıcı giriş yapmamış, giriş sayfasına yönlendir
        Get.off(LoginPage());
      }
    });

    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Uygulama yönlendirme işlemi yapılırken bir yükleme indikatörü göster
      ),
    );
  }
}
