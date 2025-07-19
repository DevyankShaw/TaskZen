import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/task_repository_impl.dart';
import '../../../data/sources/local_data_source.dart';
import '../../../domain/repositories/task_repository.dart';
import '../local_storage/isar_provider.dart';

final taskRepositoryProvider = FutureProvider<TaskRepository>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return TaskRepositoryImpl(LocalDataSource(isar));
});
