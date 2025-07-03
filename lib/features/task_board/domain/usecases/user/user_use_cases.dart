import 'create_user.dart';
import 'get_user_by_id.dart';
import 'get_users.dart';
import 'update_user.dart';

class UserUseCases {
  final GetUsers getUsers;
  final CreateUser createUser;
  final UpdateUser updateUser;
  final GetUserById getUserById;

  UserUseCases({
    required this.getUsers,
    required this.createUser,
    required this.updateUser,
    required this.getUserById,
  });
}
