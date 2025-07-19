import '../../../shared/enum/enum.dart';
import '../../../shared/mock/mock_data.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class LocalDataSource {
  // Get all tasks
  Future<List<TaskModel>> getTasks() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      return mockTaskModelist;
    } catch (_) {
      rethrow;
    }
  }

  // create task
  Future<void> createTask(TaskModel taskModel) async {
    try {
      mockTaskModelist.add(taskModel);
    } catch (e) {
      rethrow;
    }
  }

  // update task
  Future<void> updateTask(TaskModel taskModel) async {
    try {
      final updateIndex = mockTaskModelist.indexWhere(
        (element) => element.id == taskModel.id,
      );

      if (updateIndex == -1) {
        throw Exception('Task with taskId ${taskModel.id} doesn\'t exists');
      }

      mockTaskModelist[updateIndex] = taskModel;
    } catch (e) {
      rethrow;
    }
  }

  // get task by id
  Future<TaskModel?> getTaskById(int taskId) async {
    try {
      final searchIndex = mockTaskModelist.indexWhere(
        (element) => element.id == taskId,
      );
      if (searchIndex != -1) {
        return mockTaskModelist[searchIndex - 1];
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
      await Future.delayed(Duration(milliseconds: 500));
      return mockUserModelList;
    } catch (_) {
      rethrow;
    }
  }

  // create user
  Future<void> createUser(UserModel userModel) async {
    try {
      mockUserModelList.add(userModel);
    } catch (e) {
      rethrow;
    }
  }

  // update user
  Future<void> updateUser(UserModel userModel) async {
    try {
      final updateIndex = mockUserModelList.indexWhere(
        (element) => element.id == userModel.id,
      );

      if (updateIndex == -1) {
        throw Exception('User with userId ${userModel.id} doesn\'t exists');
      }

      mockUserModelList[updateIndex] = userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Get user by id
  Future<UserModel?> getUserById(int userId) async {
    try {
      final searchIndex = mockUserModelList.indexWhere(
        (element) => element.id == userId,
      );
      if (searchIndex != -1) {
        return mockUserModelList[searchIndex - 1];
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
      await Future.delayed(Duration(milliseconds: 200));

      var filteredTasks = <TaskModel>[];

      if (title?.isNotEmpty ?? false) {
        filteredTasks = mockTaskModelist
            .where((task) => task.title.toLowerCase().contains(title!))
            .toList();
      }

      if (assignees.isNotEmpty) {
        if (filteredTasks.isNotEmpty) {
          filteredTasks = filteredTasks
              .where(
                (task) => assignees.any(
                  (element) => element.id == task.assignee.value?.id,
                ),
              )
              .toList();
        } else {
          filteredTasks = mockTaskModelist
              .where(
                (task) => assignees.any(
                  (element) => element.id == task.assignee.value?.id,
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
          filteredTasks = mockTaskModelist
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
