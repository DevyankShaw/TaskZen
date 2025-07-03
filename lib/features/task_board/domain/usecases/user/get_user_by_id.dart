import 'package:fpdart/fpdart.dart';
import '../../../../shared/error/failure.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUserById {
  final UserRepository repository;

  GetUserById(this.repository);

  Future<Either<Failure, User?>> call(int userId) {
    return repository.getUserById(userId);
  }
}
