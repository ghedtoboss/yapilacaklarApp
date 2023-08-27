import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/models/user_model.dart';
import 'package:yapilcaklar/pages/home_screen.dart';
import 'package:yapilcaklar/pages/login_screen.dart';
import 'package:yapilcaklar/service/user_service.dart';

class AuthService extends GetxController {
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController mailController =
      TextEditingController(text: "sezeregemen@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "123456");

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  final userServiceController = Get.put(UserService());

  void clear() {
    adSoyadController.clear();
    mailController.clear();
    passwordController.clear();
  }

  Future<void> register() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: mailController.text, password: passwordController.text)
          .then((kullanici) {
        if (kullanici.user == null) return;
        MyUser user = MyUser(
            adSoyad: adSoyadController.text,
            id: kullanici.user!.uid,
            mail: mailController.text);

        firebase.collection("Users").doc(kullanici.user!.uid).set(user.toMap());
        Get.to(LoginPage());
      });
    } on Exception catch (e) {
      if (e.toString().contains("email address is badly formatted.")) {
        Fluttertoast.showToast(
            msg: "Email adresini düzgün formatta giriniz.",
            backgroundColor: Colors.redAccent);
      } else {
        Fluttertoast.showToast(msg: "Mail adresi zaten kullanılıyor");
      }
    }
  }

  Future<void> login() async {
    await auth
        .signInWithEmailAndPassword(
            email: mailController.text, password: passwordController.text)
        .then((userCredential) {
      userServiceController.userId.value = userCredential.user?.uid ?? "";
      Get.to(HomeScreen(), transition: Transition.fade);
    });
  }

  Future<void> quit() async {
    auth.signOut();
    clear();
  }
}
