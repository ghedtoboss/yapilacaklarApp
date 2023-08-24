import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  RxString userName = "".obs;
  RxString userId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getUserDoc();
  }

  Future<void> getUserDoc() async {
    final String id = auth.currentUser!.uid;

    final DocumentReference userDocRef =
        await firestore.collection("Users").doc(id);

    final DocumentSnapshot userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      final Map<String, dynamic> data =
          userDocSnapshot.data() as Map<String, dynamic>;

      userName.value = data["adSoyad"];
      userId.value = data["id"];
    }
  }
}
