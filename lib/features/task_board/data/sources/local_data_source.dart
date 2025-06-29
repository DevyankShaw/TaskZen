import '../../domain/entities/task.dart';
import '../models/task_model.dart';

class LocalDataSource {
  final taskModelist = <TaskModel>[
    TaskModel(
      taskId: 1,
      title: 'Design login screen',
      assigneeId: 2,
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.medium,
      status: TaskStatus.inProgress,
    ),
    TaskModel(
      taskId: 2,
      title: 'Implement API integration',
      priority: TaskPriority.low,
      status: TaskStatus.todo,
    ),
    TaskModel(
      taskId: 3,
      title: 'Fix logout bug',
      description:
          'As soon as user login and tries to logout showing Something went wrong',
      deadline: DateTime.now().add(Duration(days: 1)),
      assigneeId: 1,
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      updatedAt: DateTime.now(),
      updatedBy: 1,
    ),
    TaskModel(
      taskId: 4,
      title: 'Update onboarding docs',
      assigneeId: 3,
      priority: TaskPriority.low,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
      updatedBy: 3,
    ),
    TaskModel(
      taskId: 5,
      title: 'Refactor task bloc logic',
      assigneeId: 1,
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.high,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 4)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
      updatedBy: 1,
    ),
  ];

  // Get all tasks
  Future<List<TaskModel>> getTasks() async {
    try {
      return taskModelist;
    } catch (_) {
      rethrow;
    }
  }

  // create task
  Future<void> createTask(TaskModel taskModel) async {
    try {
      taskModelist.add(taskModel);
    } catch (e) {
      rethrow;
    }
  }

  // update task
  Future<void> updateTask(TaskModel taskModel) async {
    try {
      final upateIndex = taskModelist.indexWhere(
        (element) => element.taskId == taskModel.taskId,
      );
      taskModelist[upateIndex] = taskModel;
    } catch (e) {
      rethrow;
    }
  }
}
