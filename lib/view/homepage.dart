import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:to_do/controller/task_controller.dart';
import 'package:to_do/view/add_popup.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> tasks = [
    {'title': 'Buy groceries', 'isCompleted': false},
    {'title': 'Study Flutter', 'isCompleted': true},
    {'title': 'Walk the dog', 'isCompleted': false},
  ];

  void toggleTask(int index) {
    setState(() {
      tasks[index]['isCompleted'] = !tasks[index]['isCompleted'];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () {
            if (controller.tasks.isEmpty) {
              return const Center(child: Text("No tasks found"));
            }

            return ListView.separated(
              itemCount: controller.tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final task = controller.tasks[index];

                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      controller.toggleTask(index, value ?? false);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.deleteTask(index);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoDialog(context, (taskTitle, isCompleted) async {
            await controller.addTasks(taskTitle, isCompleted);
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
