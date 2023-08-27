import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/models/note_model.dart';
import 'package:yapilcaklar/service/user_service.dart';

class NoteService extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final userServiceController = Get.put(UserService());

  FirebaseFirestore firebase = FirebaseFirestore.instance;

  void clear() {
    titleController.clear();
    contentController.clear();
  }

  Future<void> createNote() async {
    MyNote note = MyNote(
        title: titleController.text,
        content: contentController.text,
        id: "",
        authorId: userServiceController.userId.value,
        writeDate: DateTime.now());
    DocumentReference noteDocRef =
        await firebase.collection("Notes").add(note.toMap());
    String noteDocId = noteDocRef.id;

    note = note.copyWith(id: noteDocId);

    await firebase.collection("Notes").doc(noteDocId).update(note.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersNote() {
    return firebase
        .collection("Notes")
        .where("authorId", isEqualTo: userServiceController.userId.value)
        .orderBy("writeDate")
        .snapshots();
  }

  Future<void> editNote(MyNote note, TextEditingController editTiteController,
      TextEditingController editContentController) async {
    DocumentReference noteDocRef = firebase.collection("Notes").doc(note.id);
    WriteBatch batch = firebase.batch();
    batch
        .update(noteDocRef, <String, String>{"title": editTiteController.text});

    batch.update(
        noteDocRef, <String, String>{"content": editContentController.text});

    batch.commit();
  }

  Future<void> deleteNote(MyNote note) async {
    await firebase.collection("Notes").doc(note.id).delete();
  }
}
