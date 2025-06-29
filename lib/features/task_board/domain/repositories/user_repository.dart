import 'package:fpdart/fpdart.dart' hide Task;
import 'package:taskzen/features/task_board/domain/entities/user.dart';

import '../../../shared/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, void>> createUser(User user);
  Future<Either<Failure, void>> updateUser(User user);
  Future<Either<Failure, User?>> getUserById(int userId);
}
