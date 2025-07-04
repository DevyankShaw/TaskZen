import '../../domain/entities/task.dart';
import 'user_model.dart';

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
}
