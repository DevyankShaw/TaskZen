import 'package:fpdart/fpdart.dart' hide Task;
import '../../../../shared/error/failure.dart';
import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<Either<Failure, List<Task>>> call() {
    return repository.getTasks();
  }
}
