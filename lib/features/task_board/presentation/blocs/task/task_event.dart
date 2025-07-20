part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent(this.task);
  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
  @override
  List<Object?> get props => [task];
}

class GetTaskByIdEvent extends TaskEvent {
  final int taskId;
  GetTaskByIdEvent(this.taskId);
  @override
  List<Object?> get props => [taskId];
}

class FilterTasksEvent extends TaskEvent {
  final String? title;
  final List<User> assignees;
  final List<TaskPriority> priorities;
  FilterTasksEvent({
    this.title,
    this.assignees = const [],
    this.priorities = const [],
  });
  @override
  List<Object?> get props => [title, assignees, priorities];
}

class AddAllTasksEvent extends TaskEvent {
  final List<Task> tasks;
  AddAllTasksEvent(this.tasks);
  @override
  List<Object?> get props => [tasks];
}