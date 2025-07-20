import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/user/create_all_users.dart';
import '../../../domain/usecases/user/create_user.dart';
import '../../../domain/usecases/user/get_user_by_id.dart';
import '../../../domain/usecases/user/get_users.dart';
import '../../../domain/usecases/user/update_user.dart';
import '../../../domain/usecases/user/user_use_cases.dart';
import 'user_repository_provider.dart';

final userUseCasesProvider = FutureProvider((ref) async {
  final repo = await ref.read(userRepositoryProvider.future);
  return UserUseCases(
    getUsers: GetUsers(repo),
    createUser: CreateUser(repo),
    updateUser: UpdateUser(repo),
    getUserById: GetUserById(repo),
    createAllUsers: CreateAllUsers(repo),
  );
});
