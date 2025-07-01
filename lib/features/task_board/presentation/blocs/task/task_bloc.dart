import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../../shared/enum/enum.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/task/task_use_cases.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUseCases useCases;

  TaskBloc(this.useCases) : super(TaskLoading()) {
    on<LoadTasksEvent>(_onLoad);
    on<AddTaskEvent>(_onAdd);
    on<UpdateTaskEvent>(_onUpdate);
    on<GetTaskByIdEvent>(_onLoadTaskById);
    on<FilterTasksEvent>(_onFilter);
  }

  Future<void> _onLoad(LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await useCases.getTasks();
    emit(
      result.fold(
        (fail) => TaskError(fail.message),
        (tasks) => TaskLoaded(tasks),
      ),
    );
  }

  Future<void> _onAdd(AddTaskEvent event, Emitter<TaskState> emit) async {
    final result = await useCases.createTask(event.task);
    result.fold(
      (fail) => TaskError(fail.message),
      (_) => add(LoadTasksEvent()),
    );
  }

  Future<void> _onUpdate(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    final result = await useCases.updateTask(event.task);
    result.fold(
      (fail) => TaskError(fail.message),
      (_) => add(LoadTasksEvent()),
    );
  }

  Future<void> _onLoadTaskById(
    GetTaskByIdEvent event,
    Emitter<TaskState> emit,
  ) async {
    final result = await useCases.getTaskById(event.taskId);
    result.fold(
      (fail) => TaskError(fail.message),
      (task) => SingleTaskLoaded(task),
    );
  }

  Future<void> _onFilter(
    FilterTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    final result = await useCases.filterTasks(
      title: event.title,
      assigneeIds: event.assignees.map((e) => e.id).toList(),
      priorities: event.priorities,
    );
    emit(
      result.fold(
        (fail) => TaskError(fail.message),
        (tasks) => TaskLoaded(tasks),
      ),
    );
  }
}
