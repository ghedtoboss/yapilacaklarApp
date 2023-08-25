import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
                width: Get.width,
                height: Get.height,
                color: const Color.fromARGB(255, 24, 22, 22),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      GetNotesStream(
                          noteServiceController: noteServiceController),
                    ],
                  ),
                ))),
      ),
    );
  }
}

class GetNotesStream extends StatelessWidget {
  GetNotesStream({super.key, required this.noteServiceController});
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
            return Center(child: CircularProgressIndicator());
          }

          var snapList = snapshot.data?.docs;

          return Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1),
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  MyNote note =
                      MyNote.fromMap(snapshot.data!.docs[index].data());

                  return NoteCard(
                    noteServiceController: noteServiceController,
                    note: note,
                  );
                }),
          );
        });
  }
}
