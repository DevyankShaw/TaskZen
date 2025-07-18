part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
  @override
  List<Object?> get props => [message];
}

class SingleTaskLoaded extends TaskState {
  final Task? task;
  SingleTaskLoaded(this.task);
  @override
  List<Object?> get props => [task];
}
