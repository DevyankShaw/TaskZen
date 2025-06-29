import 'package:fpdart/fpdart.dart' hide Task;

import '../../../../shared/error/failure.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  Future<Either<Failure, void>> call(Task task) {
    return repository.createTask(task);
  }
}
