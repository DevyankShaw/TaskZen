import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../blocs/user/user_bloc.dart';
import 'user_use_cases_provider.dart';

final userBlocProvider = Provider<UserBloc>((ref) {
  final useCases = ref.watch(userUseCasesProvider);
  final bloc = UserBloc(useCases);
  bloc.add(LoadUsersEvent());
  ref.onDispose(bloc.close);
  return bloc;
});

final userStateProvider = StreamProvider<UserState>((ref) {
  final bloc = ref.watch(userBlocProvider);
  return bloc.stream;
});
