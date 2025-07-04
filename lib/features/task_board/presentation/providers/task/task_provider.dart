import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../blocs/task/task_bloc.dart';
import 'task_use_cases_provider.dart';

final taskBlocProvider = FutureProvider<TaskBloc>((ref) async {
  final useCases = await ref.watch(taskUseCasesProvider.future);
  final bloc = TaskBloc(useCases);
  bloc.add(LoadTasksEvent());
  ref.onDispose(bloc.close);
  return bloc;
});

final taskStateProvider = StreamProvider<TaskState>((ref) async* {
  final bloc = await ref.watch(taskBlocProvider.future);
  yield* bloc.stream;
});
