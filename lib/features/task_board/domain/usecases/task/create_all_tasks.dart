import 'package:fpdart/fpdart.dart' hide Task;

import '../../../../shared/error/failure.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class CreateAllTasks {
  final TaskRepository repository;

  CreateAllTasks(this.repository);

  Future<Either<Failure, void>> call(List<Task> tasks) {
    return repository.createAllTasks(tasks);
  }
}
