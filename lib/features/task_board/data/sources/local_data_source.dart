import 'package:isar/isar.dart';

import '../../../shared/enum/enum.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class LocalDataSource {
  final Isar isar;
  LocalDataSource(this.isar);

  // Get all tasks
  Future<List<TaskModel>> getTasks() async {
    try {
      return await isar.writeTxn(() async {
        return await isar.taskModels.where().findAll();
      });
    } catch (_) {
      rethrow;
    }
  }

  // create task
  Future<void> createTask(TaskModel taskModel) async {
    try {
      await isar.writeTxn(() async {
        await isar.taskModels.put(taskModel);
        await taskModel.assignee.save();
      });
    } catch (e) {
      rethrow;
    }
  }

  // create all task
  Future<void> createAllTasks(List<TaskModel> taskModels) async {
    try {
      await isar.writeTxn(() async {
        await isar.taskModels.putAll(taskModels);
        await Future.wait(
          taskModels.map((taskModel) async => await taskModel.assignee.save()),
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  // update task
  Future<void> updateTask(TaskModel taskModel) async {
    try {
      await isar.writeTxn(() async {
        final taskData = await isar.taskModels.get(taskModel.id);

        if (taskData == null) {
          throw Exception('Task with taskId ${taskModel.id} doesn\'t exists');
        }

        await isar.taskModels.put(taskModel);
        await taskModel.assignee.save();
      });
    } catch (e) {
      rethrow;
    }
  }

  // get task by id
  Future<TaskModel?> getTaskById(int taskId) async {
    try {
      return await isar.writeTxn(() async {
        return await isar.taskModels.get(taskId);
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get all users
  Future<List<UserModel>> getUsers() async {
    try {
      return await isar.writeTxn(() async {
        return await isar.userModels.where().findAll();
      });
    } catch (_) {
      rethrow;
    }
  }

  // create user
  Future<void> createUser(UserModel userModel) async {
    try {
      await isar.writeTxn(() async {
        await isar.userModels.put(userModel);
      });
    } catch (e) {
      rethrow;
    }
  }

  // create all user
  Future<void> createAllUsers(List<UserModel> userModels) async {
    try {
      await isar.writeTxn(() async {
        await isar.userModels.putAll(userModels);
      });
    } catch (e) {
      rethrow;
    }
  }

  // update user
  Future<void> updateUser(UserModel userModel) async {
    try {
      await isar.writeTxn(() async {
        final userData = await isar.userModels.get(userModel.id);

        if (userData == null) {
          throw Exception('User with userId ${userModel.id} doesn\'t exists');
        }

        await isar.userModels.put(userModel);
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get user by id
  Future<UserModel?> getUserById(int userId) async {
    try {
      return await isar.writeTxn(() async {
        return await isar.userModels.get(userId);
      });
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
      return await isar.writeTxn(() async {
        final query = isar.taskModels.filter().group((gp) {
          return gp
              .titleContains(title ?? '', caseSensitive: false)
              .and()
              .anyOf(priorities, (q, priority) => q.priorityEqualTo(priority))
              .and()
              .anyOf(
                assignees,
                (q, assignee) => q.assignee((qa) => qa.idEqualTo(assignee.id)),
              );
        });

        final filteredTasks = await query.findAll();

        return filteredTasks;
      });
    } catch (_) {
      rethrow;
    }
  }
}
