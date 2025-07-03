import '../../../shared/enum/enum.dart';
import '../../domain/entities/task.dart';
import 'user_model.dart';

class TaskModel {
  late int taskId;
  late String title;
  String? description;
  UserModel? assignee;
  DateTime? deadline;
  late TaskPriority priority;
  late TaskStatus status;
  late DateTime createdAt;
  DateTime? updatedAt;

  TaskModel({
    //TODO: Remove once local storage integrated
    required this.taskId,
    required this.title,
    this.description,
    this.assignee,
    this.deadline,
    required this.priority,
    required this.status,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  TaskModel.fromEntity(Task task) {
    taskId = task.id;
    title = task.title;
    description = task.description;
    assignee = task.assignee != null
        ? UserModel.fromEntity(task.assignee!)
        : null;
    deadline = task.deadline;
    priority = task.priority;
    status = task.status;
    createdAt = task.createdAt;
    updatedAt = task.updatedAt;
  }

  Task toEntity() {
    return Task(
      id: taskId,
      title: title,
      description: description,
      assignee: assignee?.toEntity(),
      deadline: deadline,
      priority: priority,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
