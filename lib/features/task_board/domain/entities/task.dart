import 'package:equatable/equatable.dart';

import '../../../shared/enum/enum.dart';
import 'user.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final User? assignee;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.assignee,
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
      assignee: assignee ?? this.assignee,
    );
    return task;
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    deadline,
    priority,
    status,
    createdAt,
    updatedAt,
    assignee,
  ];
}
