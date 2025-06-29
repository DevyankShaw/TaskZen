import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../blocs/task/task_bloc.dart';
import 'task_usecases_provider.dart';

final taskBlocProvider = Provider<TaskBloc>((ref) {
  final useCases = ref.watch(taskUseCasesProvider);
  final bloc = TaskBloc(useCases);
  bloc.add(LoadTasksEvent());
  ref.onDispose(bloc.close);
  return bloc;
});

final taskStateProvider = StreamProvider<TaskState>((ref) {
  final bloc = ref.watch(taskBlocProvider);
  return bloc.stream;
});
