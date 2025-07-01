import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/task/create_task.dart';
import '../../../domain/usecases/task/filter_tasks.dart';
import '../../../domain/usecases/task/get_task_by_id.dart';
import '../../../domain/usecases/task/get_tasks.dart';
import '../../../domain/usecases/task/task_use_cases.dart';
import '../../../domain/usecases/task/update_task.dart';
import 'task_repository_provider.dart';

final taskUseCasesProvider = Provider((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return TaskUseCases(
    getTasks: GetTasks(repo),
    createTask: CreateTask(repo),
    updateTask: UpdateTask(repo),
    getTaskById: GetTaskById(repo),
    filterTasks: FilterTasks(repo),
  );
});
