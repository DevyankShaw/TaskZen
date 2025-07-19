import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.title,
    super.description,
    super.deadline,
    required super.priority,
    required super.status,
    required super.createdAt,
    super.updatedAt,
  });

  factory TaskModel.fromEntity(Task task) {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      deadline: task.deadline,
      priority: task.priority,
      status: task.status,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
    )..assignee.value = task.assignee.value;
    return taskModel;
  }

  Task toEntity() {
    return this;
  }
}
