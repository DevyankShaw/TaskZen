import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/mock/mock_data.dart';
import '../../blocs/task/task_bloc.dart';
import 'task_use_cases_provider.dart';

final taskBlocProvider = FutureProvider<TaskBloc>((ref) async {
  final useCases = await ref.read(taskUseCasesProvider.future);
  final bloc = TaskBloc(useCases);
  bloc.add(AddAllTasksEvent(mockTaskList));
  ref.onDispose(bloc.close);
  return bloc;
});

final taskStateProvider = StreamProvider<TaskState>((ref) async* {
  final bloc = await ref.watch(taskBlocProvider.future);
  yield* bloc.stream;
});
