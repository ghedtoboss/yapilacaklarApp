import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/pages/home_screen.dart';
import 'package:yapilcaklar/pages/login_screen.dart';

import '../models/user_model.dart';

class UserService extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  RxString userName = "".obs;
  RxString userId = "".obs;

  //auth  işlemleri için gerekli her şey;
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /*@override
  void onInit() {
    super.onInit();
    getUserDoc();
  }*/

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

        firestore
            .collection("Users")
            .doc(kullanici.user!.uid)
            .set(user.toMap());
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
        .then((value) {
      userId.value = value.user!.uid;
    });
    await getUserDoc();
    Get.to(HomeScreen(), transition: Transition.fade);
  }

  Future<void> quit() async {
    auth.signOut();
    clear();
  }

  Future<void> getUserDoc() async {
    final DocumentReference userDocRef =
        firestore.collection("Users").doc(userId.value);

    final DocumentSnapshot userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      final Map<String, dynamic> data =
          userDocSnapshot.data() as Map<String, dynamic>;

      userName.value = data["adSoyad"];
      userId.value = data["id"];
    }
  }
}
