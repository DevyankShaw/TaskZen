import 'package:fpdart/fpdart.dart' hide Task;

import '../../../shared/enum/enum.dart';
import '../../../shared/error/failure.dart';
import '../entities/task.dart';
import '../entities/user.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, void>> createTask(Task task);
  Future<Either<Failure, void>> createAllTasks(List<Task> tasks);
  Future<Either<Failure, void>> updateTask(Task task);
  Future<Either<Failure, Task?>> getTaskById(int taskId);
  Future<Either<Failure, List<Task>>> filterBy({
    String? title,
    List<User> assignees,
    List<TaskPriority> priorities,
  });
}
