import 'package:fpdart/fpdart.dart' hide Task;

import '../../../../shared/error/failure.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class CreateAllUsers {
  final UserRepository repository;

  CreateAllUsers(this.repository);

  Future<Either<Failure, void>> call(List<User> users) {
    return repository.createAllUsers(users);
  }
}
