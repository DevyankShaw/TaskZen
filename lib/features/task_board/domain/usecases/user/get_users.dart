import 'package:fpdart/fpdart.dart';
import '../../../../shared/error/failure.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<Either<Failure, List<User>>> call() {
    return repository.getUsers();
  }
}
