import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/service/auth_service.dart';

class UserService extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final authServiceController = Get.put(AuthService());

  RxString userName = "".obs;
  RxString userId = "".obs;

  @override
  void onInit() {
    super.onInit();
    userId.value = authServiceController.userId.value;
    getUserDoc();
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
