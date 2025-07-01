import 'create_task.dart';
import 'filter_tasks.dart';
import 'get_task_by_id.dart';
import 'get_tasks.dart';
import 'update_task.dart';

class TaskUseCases {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final GetTaskById getTaskById;
  final FilterTasks filterTasks;

  TaskUseCases({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.getTaskById,
    required this.filterTasks,
  });
}
