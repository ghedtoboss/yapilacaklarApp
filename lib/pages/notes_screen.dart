import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:yapilcaklar/models/note_model.dart';
import 'package:yapilcaklar/pages/add_note_screen.dart';
import 'package:yapilcaklar/service/note_service.dart';

import '../widgets/some_widgets.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  final noteServiceController = Get.put(NoteService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
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
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.purple,
          icon: const Icon(Icons.add),
          onPressed: () {
            Get.to(AddNoteScreen(), transition: Transition.rightToLeft);
          },
          label: const Text("Not ekle")),
      body: Container(
          width: Get.width,
          height: Get.height,
          color: const Color.fromARGB(255, 24, 22, 22),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                GetNotesStream(noteServiceController: noteServiceController),
              ],
            ),
          )),
    );
  }
}

class GetNotesStream extends StatelessWidget {
  const GetNotesStream({super.key, required this.noteServiceController});
  final NoteService noteServiceController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: noteServiceController.getUsersNote(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1),
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  MyNote note =
                      MyNote.fromMap(snapshot.data!.docs[index].data());

                  return NoteCard(
                    onPressed: () async {
                      await Get.to(EditNoteScreen(
                        note: note,
                      ));
                      Get.back();
                    },
                    noteServiceController: noteServiceController,
                    note: note,
                  );
                }),
          );
        });
  }
}

class EditNoteScreen extends StatelessWidget {
  EditNoteScreen({super.key, required this.note});
  final noteServiceController = Get.find<NoteService>();
  final MyNote note;

  @override
  Widget build(BuildContext context) {
    TextEditingController editTitleController =
        TextEditingController(text: note.title);
    TextEditingController editContentController =
        TextEditingController(text: note.content);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 22, 22),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
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
              height: Get.height * 0.4,
              child: const RiveAnimation.asset(
                "assets/animations/edit.riv",
                fit: BoxFit.cover,
              ),
            ),
            MyTextFieldWidget(
                controller: editTitleController,
                isObscure: false,
                labetText: "",
                iconData: Icons.edit,
                isMaxLinesNull: true),
            MyTextFieldWidget(
                controller: editContentController,
                isObscure: false,
                labetText: "",
                iconData: Icons.edit,
                isMaxLinesNull: true),
            MyElevatedButton(
                text: "Günelle",
                onPressed: () {
                  noteServiceController.editNote(
                      note, editTitleController, editContentController);
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
