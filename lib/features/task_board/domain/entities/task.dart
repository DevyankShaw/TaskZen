import 'package:equatable/equatable.dart';

enum TaskStatus { todo, inProgress, done }

enum TaskPriority { low, medium, high }

class Task extends Equatable {
  final int id;
  final String title;
  final String? description;
  final int? assigneeId;
  final DateTime? deadline;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? updatedBy;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.assigneeId,
    this.deadline,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.updatedBy,
  });

  Task copyWith({
    String? title,
    String? description,
    int? assigneeId,
    DateTime? deadline,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? updatedAt,
    int? updatedBy,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      assigneeId: assigneeId ?? this.assigneeId,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    assigneeId,
    deadline,
    priority,
    status,
    createdAt,
    updatedAt,
    updatedBy,
  ];
}
