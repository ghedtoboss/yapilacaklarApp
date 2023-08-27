import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:yapilcaklar/service/note_service.dart';
import 'package:yapilcaklar/widgets/some_widgets.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});
  final noteServiceController = Get.put(NoteService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              noteServiceController.clear();
            },
            icon: const Icon(Icons.arrow_back_ios)),
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
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: Get.height * 0.3,
              child: const RiveAnimation.asset(
                "assets/animations/new_file.riv",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MyTextFieldWidget(
                  isMaxLinesNull: true,
                  controller: noteServiceController.titleController,
                  isObscure: false,
                  labetText: "Not başlığı",
                  iconData: Icons.title),
            ),
            MyTextFieldWidget(
                isMaxLinesNull: true,
                controller: noteServiceController.contentController,
                isObscure: false,
                labetText: "Not içeriği",
                iconData: Icons.content_paste),
            SizedBox(
              height: Get.height * 0.1,
            ),
            MyElevatedButton(
                text: "Ekle",
                onPressed: () {
                  noteServiceController.createNote();
                  Get.back();
                  noteServiceController.clear();
                })
          ],
        ),
      ),
    );
  }
}
