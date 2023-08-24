import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/pages/login_screen.dart';
import 'package:yapilcaklar/pages/today_screen.dart';
import 'package:yapilcaklar/pages/todos_screen.dart';
import 'package:yapilcaklar/service/auth_service.dart';
import 'package:yapilcaklar/service/todo_service.dart';
import 'package:yapilcaklar/service/user_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final userServiceController = Get.put(UserService());
  final authController = Get.put(AuthService());
  final todoServiceController = Get.put(ToDoService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 22, 22),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                authController.quit();
                Get.to(LoginPage());
              },
              icon: const Icon(Icons.logout)),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 24, 22, 22),
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/homeLogo.png"))),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            color: const Color.fromARGB(255, 24, 22, 22),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HOŞGELDİN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: "carter"),
                  ),
                  Obx(
                    () => Text(
                      userServiceController.userName.value,
                      style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 50,
                          fontFamily: "luck"),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.08,
                  ),
                  GetTodayTodosCount(
                    todoServiceController: todoServiceController,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ToDosScreen(), transition: Transition.rightToLeft);
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 24, 22, 22),
                                Color.fromARGB(255, 94, 17, 108)
                              ])),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "YAPILCAKLAR",
                                  style: TextStyle(
                                      fontFamily: "luck",
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.list_alt_rounded,
                                  color: Colors.white,
                                  size: 40,
                                )
                              ],
                            ),
                            Icon(
                              Icons.forward,
                              color: Colors.white,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(TodayToDosScreen());
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 94, 17, 108),
                                Color.fromARGB(255, 24, 22, 22)
                              ])),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BUGÜN NE VAR?",
                                  style: TextStyle(
                                      fontFamily: "luck",
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.today,
                                  color: Colors.white,
                                  size: 40,
                                )
                              ],
                            ),
                            Icon(
                              Icons.forward,
                              color: Colors.white,
                              size: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class GetTodayTodosCount extends StatelessWidget {
  GetTodayTodosCount({super.key, required this.todoServiceController});
  final ToDoService todoServiceController;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: todoServiceController.getUserTodayTodos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Veri beklenirken döndürülen widget
        } else if (snapshot.hasError) {
          return Text(
              "Hata: ${snapshot.error}"); // Hata durumunda döndürülen widget
        } else {
          // Stream'den dönen verinin sayısı alınıyor
          int count = snapshot.data?.docs.length ?? 0;

          return FittedBox(
              child: RichText(
            text: TextSpan(
              style: TextStyle(
                  fontFamily: "luck", fontSize: 30, color: Colors.white),
              children: <TextSpan>[
                TextSpan(text: "Bugün yapılacak işlerin\nsayısı: "),
                TextSpan(
                    text: '$count',
                    style: TextStyle(
                        color: Colors
                            .purple)), // count değerinin rengini değiştiriyoruz
              ],
            ),
          ));
        }
      },
    );
  }
}
