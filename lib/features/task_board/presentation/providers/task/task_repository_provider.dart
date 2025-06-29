import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/task_repository_impl.dart';
import '../../../data/sources/local_data_source.dart';
import '../../../domain/repositories/task_repository.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(LocalDataSource());
});
