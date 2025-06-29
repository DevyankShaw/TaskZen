import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/user/create_user.dart';
import '../../../domain/usecases/user/get_user_by_id.dart';
import '../../../domain/usecases/user/get_users.dart';
import '../../../domain/usecases/user/update_user.dart';
import '../../../domain/usecases/user/user_use_cases.dart';
import 'user_repository_provider.dart';

final userUseCasesProvider = Provider((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserUseCases(
    getUsers: GetUsersUseCase(repo),
    createUser: CreateUserUseCase(repo),
    updateUser: UpdateUserUseCase(repo),
    getUserById: GetUserByIdUseCase(repo),
  );
});
