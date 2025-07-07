import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: tasks.isEmpty
            ? const Center(child: Text("No tasks added yet"))
            : ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: task['isCompleted'],
                        onChanged: (_) => toggleTask(index),
                      ),
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: task['isCompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 16,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoDialog(context, (task) {
            setState(() {
              tasks.add({'title': task, 'isCompleted': false});
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
