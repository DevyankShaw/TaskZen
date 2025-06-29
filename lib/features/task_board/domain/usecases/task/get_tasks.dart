import 'package:fpdart/fpdart.dart' hide Task;
import '../../../../shared/error/failure.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<Either<Failure, List<Task>>> call() {
    return repository.getTasks();
  }
}
