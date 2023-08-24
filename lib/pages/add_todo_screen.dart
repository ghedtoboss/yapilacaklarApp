import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yapilcaklar/enumsAndExts/extensions.dart';
import 'package:yapilcaklar/service/todo_service.dart';
import 'package:yapilcaklar/widgets/some_widgets.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});
  final todoServiceController = Get.put(ToDoService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              todoServiceController.clear();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 24, 22, 22),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/homeLogo.png"))),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: Get.width,
        height: Get.height,
        color: const Color.fromARGB(255, 24, 22, 22),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.3,
            ),
            MyTextFieldWidget(
              isMaxLinesNull: true,
                controller: todoServiceController.todoController,
                isObscure: false,
                labetText: "Görev tanımı",
                iconData: Icons.notes_sharp),
            DateTimePicker(todoServiceController: todoServiceController),
            SizedBox(
              height: Get.height * 0.3,
            ),
            MyElevatedButton(
                text: "Ekle",
                onPressed: () {
                  todoServiceController.createToDo();
                  Get.back();
                  todoServiceController.clear();
                })
          ],
        ),
      )),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key, required this.todoServiceController});

  final ToDoService todoServiceController;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todoServiceController.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != todoServiceController.selectedDate.value)
      todoServiceController.changeSelectedDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              icon: const Icon(Icons.date_range),
              onPressed: () => _selectDate(context),
              label: const Text('Tarih seç'),
            ),
            Obx(() => Text(
                  "Yapılması gereken tarih: ${todoServiceController.selectedDate.value.formatDate}",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )
      ],
    );
  }
}
