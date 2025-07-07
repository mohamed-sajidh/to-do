import 'package:flutter/material.dart';
import 'package:get/get.dart';

void addTodoDialog(BuildContext context, Function(String, bool) onAdd) {
  final TextEditingController todoController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Add New Task"),
        content: TextField(
          controller: todoController,
          decoration: const InputDecoration(
            hintText: "Enter your task",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final String task = todoController.text.trim();
              if (task.isNotEmpty) {
                onAdd(task, false); // pass to callback
                Get.back();
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
