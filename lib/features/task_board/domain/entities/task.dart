import 'package:equatable/equatable.dart';

import '../../../shared/enum/enum.dart';
import 'user.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String? description;
  final User? assignee;
  final DateTime? deadline;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Task({
    //TODO: Need to check for auto increment during local storage integration 
    required this.id,
    required this.title,
    this.description,
    this.assignee,
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
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    assignee,
    deadline,
    priority,
    status,
    createdAt,
    updatedAt,
  ];
}
