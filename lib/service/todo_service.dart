import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/models/todo_model.dart';
import 'package:yapilcaklar/service/user_service.dart';

class ToDoService extends GetxController {
  final userServiceController = Get.put(UserService());
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  TextEditingController todoController = TextEditingController();

  var selectedDate = DateTime.now().obs;

  void changeSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void clear() {
    todoController.clear();
    selectedDate.value = DateTime.now();
  }

  Future<void> createToDo() async {
    MyToDo todo = MyToDo(
        id: "id",
        authorId: userServiceController.userId.value,
        todo: todoController.text,
        isFinished: false,
        writeDate: DateTime.now(),
        date: selectedDate.value);
    DocumentReference todoDocRef =
        await firebase.collection("Todos").add(todo.toMap());
    String docId = todoDocRef.id;

    todo = todo.copyWith(id: docId);

    await firebase.collection("Todos").doc(docId).update(todo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserTodos() {
    return FirebaseFirestore.instance
        .collection("Todos")
        .where("authorId", isEqualTo: userServiceController.userId.value)
        .orderBy("date")
        .snapshots();
  }

  //bugünün todoları için
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserTodayTodos() {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    int startMillis = startOfDay.millisecondsSinceEpoch;
    int endMillis = endOfDay.millisecondsSinceEpoch;

    return FirebaseFirestore.instance
        .collection("Todos")
        .where("authorId", isEqualTo: userServiceController.userId.value)
        .where("date", isGreaterThanOrEqualTo: startMillis)
        .where("date", isLessThanOrEqualTo: endMillis)
        .snapshots();
  }

  Future<void> finishedTodo(MyToDo todo) async {
    await firebase.collection("Todos").doc(todo.id).delete();
  }
}
