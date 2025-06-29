import 'create_task.dart';
import 'get_tasks.dart';
import 'update_task.dart';

class TaskUseCases {
  final GetTasksUseCase getTasks;
  final CreateTaskUseCase createTask;
  final UpdateTaskUseCase updateTask;

  TaskUseCases({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
  });
}
