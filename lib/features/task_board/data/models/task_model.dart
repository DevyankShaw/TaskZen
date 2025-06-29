import '../../domain/entities/task.dart';

class TaskModel {
  late int taskId;
  late String title;
  String? description;
  int? assigneeId;
  DateTime? deadline;
  late TaskPriority priority;
  late TaskStatus status;
  late DateTime createdAt;
  DateTime? updatedAt;
  int? updatedBy;

  TaskModel({
    //TODO: Remove once local storage integrated
    required this.taskId,
    required this.title,
    this.description,
    this.assigneeId,
    this.deadline,
    required this.priority,
    required this.status,
    DateTime? createdAt,
    this.updatedAt,
    this.updatedBy,
  }) : createdAt = createdAt ?? DateTime.now();

  TaskModel.fromEntity(Task task) {
    taskId = task.id;
    title = task.title;
    description = task.description;
    assigneeId = task.assigneeId;
    deadline = task.deadline;
    priority = task.priority;
    status = task.status;
    createdAt = task.createdAt;
    updatedAt = task.updatedAt;
    updatedBy = task.updatedBy;
  }

  Task toEntity() {
    return Task(
      id: taskId,
      title: title,
      description: description,
      assigneeId: assigneeId,
      deadline: deadline,
      priority: priority,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
    );
  }
}
