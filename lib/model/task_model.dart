import 'package:hive_flutter/hive_flutter.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool isCompleted;

  const TaskModel(this.title, this.isCompleted);
}
