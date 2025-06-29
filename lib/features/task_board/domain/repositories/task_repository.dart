import 'package:fpdart/fpdart.dart' hide Task;

import '../../../shared/error/failure.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, void>> createTask(Task task);
  Future<Either<Failure, void>> updateTask(Task task);
  Future<Either<Failure, Task?>> getTaskById(int taskId);
}
