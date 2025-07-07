import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/model/task_model.dart';

class TaskController extends GetxController {
  late Box<TaskModel> taskBox;
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    taskBox = Hive.box<TaskModel>('taskBox');
    loadTasks();
  }

  void loadTasks() {
    tasks.value = taskBox.values.toList();
  }

  Future<void> addTasks(String task, bool isCompleted) async {
    try {
      final taskModel = TaskModel(task, isCompleted);
      await taskBox.add(taskModel);
      loadTasks();

      Get.snackbar(
        "Success",
        "Task added successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print("Error occurred while adding task: $e");
      Get.snackbar(
        "Error",
        "Failed to add task.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> toggleTask(int index, bool value) async {
    final task = taskBox.getAt(index);
    if (task != null) {
      final updated = TaskModel(task.title, value);
      await taskBox.putAt(index, updated);
      loadTasks();
    }
  }

  Future<void> deleteTask(int index) async {
    await taskBox.deleteAt(index);
    loadTasks();
  }
}
