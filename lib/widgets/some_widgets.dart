import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/enumsAndExts/extensions.dart';
import 'package:yapilcaklar/models/note_model.dart';
import 'package:yapilcaklar/models/todo_model.dart';
import 'package:yapilcaklar/service/note_service.dart';
import 'package:yapilcaklar/service/todo_service.dart';

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({
    super.key,
    required this.controller,
    required this.isObscure,
    required this.labetText,
    required this.iconData,
    required this.isMaxLinesNull,
  });
  final TextEditingController controller;
  final bool isObscure;
  final String labetText;
  final IconData iconData;
  final bool isMaxLinesNull;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: controller,
        maxLines: isMaxLinesNull ? null : 1,
        obscureText: isObscure,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.purple,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple, width: 1.0),
            ),
            labelText: labetText,
            labelStyle: const TextStyle(color: Colors.white),
            prefixIcon: Icon(
              iconData,
              color: Colors.purple,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple, width: 2.0),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      child: Text(text),
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: TextButton.styleFrom(primary: Colors.purple),
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard(
      {super.key, required this.todo, required this.todoServiceController});
  final MyToDo todo;
  final ToDoService todoServiceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: Get.height * 0.6,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 22, 22),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width * 0.7,
                            height: Get.height * 0.4,
                            child: Text(
                              todo.todo,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "carter",
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            todo.date.formatDate,
                            style: TextStyle(
                                fontFamily: "robotolight",
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          width: Get.width,
          height: Get.height * 0.1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width * 0.7,
                      child: Text(
                        todo.todo,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "carter",
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      todo.date.formatDate,
                      style: TextStyle(fontFamily: "robotolight", fontSize: 15),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                width: Get.width * 0.8,
                                height: Get.height * 0.25,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 24, 22, 22),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Görevinizi yaptınız mı?",
                                        style: TextStyle(
                                            fontFamily: "luck",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      Container(
                                          width: Get.width * 0.8,
                                          height: Get.height * 0.08,
                                          child: Text(
                                            "Eminseniz tamamla butonuna basabilirsiniz.\nGörev silinecek",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "robotomedium",
                                                fontSize: 18),
                                          )),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "İPTAL",
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontFamily: "robotomedium",
                                                    fontSize: 15),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                todoServiceController
                                                    .finishedTodo(todo);
                                                Get.back();
                                              },
                                              child: Text(
                                                "Tamamla",
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontFamily: "robotomedium",
                                                    fontSize: 15),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.circle_outlined,
                      color: Colors.purple,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomeContainer extends StatelessWidget {
  const MyHomeContainer(
      {super.key,
      required this.widget,
      required this.text,
      required this.iconData1,
      required this.iconData2});
  final Widget widget;
  final String text;
  final IconData iconData1;
  final IconData iconData2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(widget, transition: Transition.rightToLeft);
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
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontFamily: "luck", fontSize: 30, color: Colors.white),
                  ),
                  Icon(
                    iconData1,
                    color: Colors.white,
                    size: 40,
                  )
                ],
              ),
              Icon(
                iconData2,
                color: Colors.white,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.noteServiceController,
  });
  final MyNote note;
  final NoteService noteServiceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    height: Get.height * 0.6,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 22, 22),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  noteServiceController.deleteNote(note);
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width * 0.7,
                            height: Get.height * 0.08,
                            child: Text(
                              note.title,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "carter",
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width * 0.7,
                            height: Get.height * 0.3,
                            child: Text(
                              note.content,
                              style: const TextStyle(
                                  fontFamily: "robotolight",
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          width: Get.width * 0.4,
          height: Get.height * 0.2,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 217, 217),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: Get.height * 0.05,
                child: Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "carter",
                  ),
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1,
                color: Colors.black,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                height: Get.height * 0.131,
                width: Get.width * 0.4,
                child: Text(
                  note.content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "robomedium",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
