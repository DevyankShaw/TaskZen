import 'package:fpdart/fpdart.dart' hide Task;
import 'package:taskzen/features/task_board/data/sources/local_data_source.dart';
import 'package:taskzen/features/task_board/domain/entities/task.dart';
import 'package:taskzen/features/task_board/domain/repositories/task_repository.dart';

import '../../../shared/error/failure.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final models = await localDataSource.getTasks();
      final tasks = models.map((model) => model.toEntity()).toList();
      return Either.right(tasks);
    } catch (e) {
      return Either.left(ServerFailure('Failed to get tasks: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> createTask(Task task) async {
    try {
      final model = TaskModel.fromEntity(task);
      await localDataSource.createTask(model);
      return Either.right(null);
    } catch (e) {
      return Either.left(ServerFailure('Failed to create task: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(Task task) async {
    try {
      final model = TaskModel.fromEntity(task);
      await localDataSource.updateTask(model);
      return Either.right(null);
    } catch (e) {
      return Either.left(ServerFailure('Failed to update task: $e'));
    }
  }

  @override
  Future<Either<Failure, Task?>> getTaskById(int taskId) async {
    try {
      final model = await localDataSource.getTaskById(taskId);
      final task = model?.toEntity();
      return Either.right(task);
    } catch (e) {
      return Either.left(ServerFailure('Failed to get task by id: $e'));
    }
  }
}
