import 'package:fpdart/fpdart.dart' hide Task;

import '../../../shared/error/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, void>> createUser(User user);
  Future<Either<Failure, void>> updateUser(User user);
  Future<Either<Failure, User?>> getUserById(int userId);
}
