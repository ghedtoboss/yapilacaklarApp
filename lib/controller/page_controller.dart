import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/pages/home_screen.dart';
import 'package:yapilcaklar/pages/settings_screen.dart';
import 'package:yapilcaklar/pages/todo_screen.dart';

class HomePageController extends GetxController {
  RxInt currentPage = 1.obs;

  RxList<Widget> pages =
      <Widget>[ToDoScreen(), HomeScreen(), SettingsScreen()].obs;
}
