import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/pages/login_screen.dart';
import 'package:yapilcaklar/pages/notes_screen.dart';
import 'package:yapilcaklar/pages/today_screen.dart';
import 'package:yapilcaklar/pages/todos_screen.dart';
import 'package:yapilcaklar/service/auth_service.dart';
import 'package:yapilcaklar/service/todo_service.dart';
import 'package:yapilcaklar/service/user_service.dart';
import '../widgets/some_widgets.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HOŞGELDİN",
                style: TextStyle(
                    color: Colors.white, fontSize: 40, fontFamily: "carter"),
              ),
              Obx(
                () => Text(
                  userServiceController.userName.value,
                  style: const TextStyle(
                      color: Colors.purple, fontSize: 50, fontFamily: "luck"),
                ),
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
              GetTodayTodosCount(),
              SizedBox(
                height: Get.height * 0.05,
              ),
              MyHomeContainer(
                  widget: ToDosScreen(),
                  text: "Yapılacaklar",
                  iconData1: Icons.list_alt_outlined,
                  iconData2: Icons.forward),
              SizedBox(
                height: Get.height * 0.02,
              ),
              MyHomeContainer(
                  widget: TodayToDosScreen(),
                  text: "Bugün ne var?",
                  iconData1: Icons.today,
                  iconData2: Icons.forward),
              SizedBox(
                height: Get.height * 0.02,
              ),
              MyHomeContainer(
                  widget: NotesScreen(),
                  text: "Notlarım",
                  iconData1: Icons.note_rounded,
                  iconData2: Icons.forward),
            ],
          ),
        ),
      ),
    );
  }
}

class GetTodayTodosCount extends StatelessWidget {
  GetTodayTodosCount({
    super.key,
  });
  final todoServiceController = Get.put(ToDoService());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: todoServiceController.getUserTodayTodos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); //
        } else if (snapshot.hasError) {
          return Text("Hata: ${snapshot.error}");
        } else {
          int count = snapshot.data?.docs.length ?? 0;

          return FittedBox(
              child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontFamily: "luck", fontSize: 30, color: Colors.white),
              children: <TextSpan>[
                const TextSpan(text: "Bugün yapılacak işlerin\nsayısı: "),
                TextSpan(
                    text: '$count',
                    style: const TextStyle(color: Colors.purple)),
              ],
            ),
          ));
        }
      },
    );
  }
}
