import 'package:isar/isar.dart';

import '../../../shared/enum/enum.dart';
import 'user.dart';

part 'task.g.dart';

@collection
class Task {
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
  final IsarLink<User> assignee = IsarLink<User>();

  Task({
    this.id = Isar.autoIncrement,
    required this.title,
    this.description,
    this.deadline,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  Task copyWith({
    String? title,
    String? description,
    User? assignee,
    DateTime? deadline,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? updatedAt,
  }) {
    final task = Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    task.assignee.value = assignee ?? this.assignee.value;
    return task;
  }
}
