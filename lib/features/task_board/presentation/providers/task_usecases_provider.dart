import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/usecases.dart';
import 'task_repository_provider.dart';

final taskUseCasesProvider = Provider((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return TaskUseCases(
    getTasks: GetTasksUseCase(repo),
    createTask: CreateTaskUseCase(repo),
    updateTask: UpdateTaskUseCase(repo),
  );
});
