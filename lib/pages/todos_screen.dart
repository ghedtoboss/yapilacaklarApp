import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:yapilcaklar/models/todo_model.dart';
import 'package:yapilcaklar/pages/add_todo_screen.dart';
import 'package:yapilcaklar/service/todo_service.dart';

import '../widgets/some_widgets.dart';

class ToDosScreen extends StatelessWidget {
  ToDosScreen({super.key});
  final todoServiceController = Get.put(ToDoService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
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
        onPressed: () {
          Get.to(AddTodoPage(), transition: Transition.rightToLeft);
        },
        label: const Text("Ekle"),
        icon: const Icon(Icons.add),
      ),
      body: Container(
          width: Get.width,
          height: Get.height,
          color: const Color.fromARGB(255, 24, 22, 22),
          child: Column(
            children: [
              GetUserTodos(todoServiceController: todoServiceController),
            ],
          )),
    );
  }
}

class GetUserTodos extends StatelessWidget {
  const GetUserTodos({super.key, required this.todoServiceController});
  final ToDoService todoServiceController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: todoServiceController.getUserTodos(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  MyToDo todo =
                      MyToDo.fromMap(snapshot.data!.docs[index].data());

                  return TodoCard(
                    todo: todo,
                    todoServiceController: todoServiceController,
                  );
                }),
          );
        });
  }
}

class EditTodoScreen extends StatelessWidget {
  EditTodoScreen({super.key, required this.todo});
  final todoServiceController = Get.find<ToDoService>();
  final MyToDo todo;

  @override
  Widget build(BuildContext context) {
    TextEditingController editTodoController =
        TextEditingController(text: todo.todo);
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
                controller: editTodoController,
                isObscure: false,
                labetText: "",
                iconData: Icons.edit,
                isMaxLinesNull: true),
            MyElevatedButton(
                text: "Günelle",
                onPressed: () {
                  todoServiceController.editTodo(todo, editTodoController);
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
