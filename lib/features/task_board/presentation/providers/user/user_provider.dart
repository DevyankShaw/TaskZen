import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/mock/mock_data.dart';
import '../../blocs/user/user_bloc.dart';
import 'user_use_cases_provider.dart';

final userBlocProvider = FutureProvider<UserBloc>((ref) async {
  final useCases = await ref.read(userUseCasesProvider.future);
  final bloc = UserBloc(useCases);
  bloc.add(AddAllUsersEvent(mockUserList));
  ref.onDispose(bloc.close);
  return bloc;
});

final userStateProvider = StreamProvider<UserState>((ref) async* {
  final bloc = await ref.watch(userBlocProvider.future);
  yield* bloc.stream;
});
