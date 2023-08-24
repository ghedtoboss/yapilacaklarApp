import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:yapilcaklar/pages/register_screen.dart';
import 'package:yapilcaklar/service/auth_service.dart';
import 'package:yapilcaklar/widgets/some_widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final authController = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: Get.width,
            height: Get.height,
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
                  child: RiveAnimation.asset("assets/animations/logo.riv"),
                ),
                MyTextFieldWidget(
                    isMaxLinesNull: true,
                    controller: authController.mailController,
                    isObscure: false,
                    labetText: "Email",
                    iconData: Icons.mail),
                MyTextFieldWidget(
                    isMaxLinesNull: false,
                    controller: authController.passwordController,
                    isObscure: true,
                    labetText: "Şifre",
                    iconData: Icons.key),
                MyTextButton(onPressed: () {}, text: "Şifreni mi unuttun?"),
                MyElevatedButton(
                    text: "Giriş",
                    onPressed: () {
                      authController.login();
                    }),
                SizedBox(
                  height: Get.height * 0.15,
                ),
                MyTextButton(
                    onPressed: () {
                      Get.to(RegisterPage(),
                          transition: Transition.rightToLeft);
                    },
                    text: "Kayıt ol!")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
