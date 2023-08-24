import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/service/auth_service.dart';

import '../widgets/some_widgets.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final authController = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: Get.width,
            //height: Get.height,
            color: const Color.fromARGB(255, 24, 22, 22),
            child: Column(
              children: [
                const FittedBox(
                  child: Text(
                    "HOŞGELDİNİZ",
                    style: TextStyle(
                        color: Colors.purple, fontFamily: "luck", fontSize: 45),
                  ),
                ),
                Container(
                  width: Get.width * 0.6,
                  height: Get.height * 0.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.jpg"))),
                ),
                MyTextFieldWidget(
                    controller: authController.adSoyadController,
                    isObscure: false,
                    labetText: "Ad soyad",
                    iconData: Icons.person),
                MyTextFieldWidget(
                    controller: authController.mailController,
                    isObscure: false,
                    labetText: "Email",
                    iconData: Icons.mail),
                MyTextFieldWidget(
                    controller: authController.passwordController,
                    isObscure: true,
                    labetText: "Şifre",
                    iconData: Icons.key),
                MyTextButton(onPressed: () {}, text: "Şifreni mi unuttun?"),
                MyElevatedButton(
                    text: "Kayıt ol",
                    onPressed: () {
                      authController.register();
                    }),
                MyTextButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: "Zaten kayıtlı mısın?")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
