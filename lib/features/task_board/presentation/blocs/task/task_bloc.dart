import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/entities/task.dart';
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
}
