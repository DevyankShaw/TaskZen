import 'package:fpdart/fpdart.dart';
import '../../../../shared/error/failure.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUserByIdUseCase {
  final UserRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<Either<Failure, User?>> call(int userId) {
    return repository.getUserById(userId);
  }
}
