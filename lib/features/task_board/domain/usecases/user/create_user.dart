import 'package:fpdart/fpdart.dart' hide Task;

import '../../../../shared/error/failure.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase(this.repository);

  Future<Either<Failure, void>> call(User user) {
    return repository.createUser(user);
  }
}
