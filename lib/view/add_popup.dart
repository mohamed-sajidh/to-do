import 'package:flutter/material.dart';

void addTodoDialog(BuildContext context, Function(String) onAdd) {
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
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text("Add"),
            onPressed: () {
              final String task = todoController.text.trim();
              if (task.isNotEmpty) {
                onAdd(task);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
