import '../../../shared/enum/enum.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class LocalDataSource {
  late final userModelList = <UserModel>[
    UserModel(
      userId: 1,
      name: 'Alice',
      email: 'alice@gmail.com',
      role: Role.designer,
    ),
    UserModel(
      userId: 2,
      name: 'Bob',
      email: 'bob@gmail.com',
      role: Role.developer,
    ),
    UserModel(
      userId: 3,
      name: 'Charlie',
      email: 'charlie@gmail.com',
      role: Role.developer,
    ),
    UserModel(
      userId: 4,
      name: 'Diana',
      email: 'diana@gmail.com',
      role: Role.productOwner,
    ),
    UserModel(
      userId: 5,
      name: 'Rahul',
      email: 'rahul@gmail.com',
      role: Role.tester,
    ),
  ];

  late final taskModelist = <TaskModel>[
    TaskModel(
      taskId: 1,
      title: 'Design login screen',
      assignee: userModelList.singleWhere((element) => element.userId == 1),
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.medium,
      status: TaskStatus.todo,
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
      assignee: userModelList.singleWhere((element) => element.userId == 2),
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      updatedAt: DateTime.now(),
    ),
    TaskModel(
      taskId: 4,
      title: 'Update onboarding docs',
      assignee: userModelList.singleWhere((element) => element.userId == 4),
      priority: TaskPriority.low,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    TaskModel(
      taskId: 5,
      title: 'Refactor task bloc logic',
      assignee: userModelList.singleWhere((element) => element.userId == 3),
      deadline: DateTime.now().add(Duration(days: 2)),
      priority: TaskPriority.high,
      status: TaskStatus.done,
      createdAt: DateTime.now().subtract(Duration(days: 4)),
      updatedAt: DateTime.now().subtract(Duration(days: 2)),
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

  // get task by id
  Future<TaskModel?> getTaskById(int taskId) async {
    try {
      final searchIndex = taskModelist.indexWhere(
        (element) => element.taskId == taskId,
      );
      if (searchIndex != -1) {
        return taskModelist[searchIndex - 1];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get all users
  Future<List<UserModel>> getUsers() async {
    try {
      return userModelList;
    } catch (_) {
      rethrow;
    }
  }

  // create user
  Future<void> createUser(UserModel userModel) async {
    try {
      userModelList.add(userModel);
    } catch (e) {
      rethrow;
    }
  }

  // update user
  Future<void> updateUser(UserModel userModel) async {
    try {
      final upateIndex = userModelList.indexWhere(
        (element) => element.userId == userModel.userId,
      );
      userModelList[upateIndex] = userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Get user by id
  Future<UserModel?> getUserById(int userId) async {
    try {
      final searchIndex = userModelList.indexWhere(
        (element) => element.userId == userId,
      );
      if (searchIndex != -1) {
        return userModelList[searchIndex - 1];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Filter tasks by title or assignee or priority
  Future<List<TaskModel>> filterBy({
    String? title,
    List<UserModel> assignees = const [],
    List<TaskPriority> priorities = const [],
  }) async {
    try {
      var filteredTasks = <TaskModel>[];

      if (title?.isNotEmpty ?? false) {
        filteredTasks = taskModelist
            .where((task) => task.title.toLowerCase().contains(title!))
            .toList();
      }

      if (assignees.isNotEmpty) {
        if (filteredTasks.isNotEmpty) {
          filteredTasks = filteredTasks
              .where(
                (task) => assignees.any(
                  (element) => element.userId == task.assignee?.userId,
                ),
              )
              .toList();
        } else {
          filteredTasks = taskModelist
              .where(
                (task) => assignees.any(
                  (element) => element.userId == task.assignee?.userId,
                ),
              )
              .toList();
        }
      }

      if (priorities.isNotEmpty) {
        if (filteredTasks.isNotEmpty) {
          filteredTasks = filteredTasks
              .where((task) => priorities.contains(task.priority))
              .toList();
        } else {
          filteredTasks = taskModelist
              .where((task) => priorities.contains(task.priority))
              .toList();
        }
      }

      return filteredTasks;
    } catch (_) {
      rethrow;
    }
  }
}
