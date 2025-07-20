import 'package:isar/isar.dart';

import '../../../shared/enum/enum.dart';
import '../../domain/entities/task.dart';
import 'user_model.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  final Id id;
  final String title;
  final String? description;
  final DateTime? deadline;
  @enumerated
  final TaskPriority priority;
  @enumerated
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final IsarLink<UserModel> assignee = IsarLink<UserModel>();

  TaskModel({
    this.id = Isar.autoIncrement,
    required this.title,
    this.description,
    this.deadline,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromEntity(Task task) {
    final taskModel =
        TaskModel(
            id: task.id,
            title: task.title,
            description: task.description,
            deadline: task.deadline,
            priority: task.priority,
            status: task.status,
            createdAt: task.createdAt,
            updatedAt: task.updatedAt,
          )
          ..assignee.value = task.assignee != null
              ? UserModel.fromEntity(task.assignee!)
              : null;
    return taskModel;
  }

  Task toEntity() => Task(
    id: id,
    title: title,
    description: description,
    assignee: assignee.value?.toEntity(),
    deadline: deadline,
    priority: priority,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
