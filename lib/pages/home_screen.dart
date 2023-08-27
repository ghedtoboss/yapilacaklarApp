import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/pages/login_screen.dart';
import 'package:yapilcaklar/pages/notes_screen.dart';
import 'package:yapilcaklar/pages/today_screen.dart';
import 'package:yapilcaklar/pages/todos_screen.dart';
import 'package:yapilcaklar/service/todo_service.dart';
import 'package:yapilcaklar/service/user_service.dart';
import '../widgets/some_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final userServiceController = Get.put(UserService());
  final todoServiceController = Get.put(ToDoService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              userServiceController.quit();
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
              const Text(
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
