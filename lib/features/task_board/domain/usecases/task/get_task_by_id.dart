import 'package:fpdart/fpdart.dart' hide Task;
import '../../../../shared/error/failure.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class GetTaskById {
  final TaskRepository repository;

  GetTaskById(this.repository);

  Future<Either<Failure, Task?>> call(int taskId) {
    return repository.getTaskById(taskId);
  }
}
