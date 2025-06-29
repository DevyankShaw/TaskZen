import 'package:fpdart/fpdart.dart' hide Task;

import '../../../../shared/error/failure.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<Either<Failure, void>> call(Task task) {
    return repository.updateTask(task);
  }
}
