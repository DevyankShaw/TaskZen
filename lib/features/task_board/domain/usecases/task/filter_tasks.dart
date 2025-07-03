import 'package:fpdart/fpdart.dart' hide Task;
import '../../../../shared/enum/enum.dart';
import '../../../../shared/error/failure.dart';
import '../../entities/task.dart';
import '../../entities/user.dart';
import '../../repositories/task_repository.dart';

class FilterTasks {
  final TaskRepository repository;

  FilterTasks(this.repository);

  Future<Either<Failure, List<Task>>> call({
    String? title,
    List<User> assignees = const [],
    List<TaskPriority> priorities = const [],
  }) async {
    return repository.filterBy(
      title: title,
      assignees: assignees,
      priorities: priorities,
    );
  }
}
