import 'create_user.dart';
import 'get_user_by_id.dart';
import 'get_users.dart';
import 'update_user.dart';

class UserUseCases {
  final GetUsersUseCase getUsers;
  final CreateUserUseCase createUser;
  final UpdateUserUseCase updateUser;
  final GetUserByIdUseCase getUserById;

  UserUseCases({
    required this.getUsers,
    required this.createUser,
    required this.updateUser,
    required this.getUserById,
  });
}