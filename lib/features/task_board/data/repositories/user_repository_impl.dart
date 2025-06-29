import 'package:fpdart/fpdart.dart';
import 'package:taskzen/features/shared/error/failure.dart';

import 'package:taskzen/features/task_board/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../sources/local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, User?>> getUserById(int userId) async {
    try {
      final model = await localDataSource.getUserById(userId);
      final user = model?.toEntity();
      return Either.right(user);
    } catch (e) {
      return Either.left(ServerFailure('Failed to get user by id: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> createUser(User user) async {
    try {
      final model = UserModel.fromEntity(user);
      await localDataSource.createUser(model);
      return Either.right(null);
    } catch (e) {
      return Either.left(ServerFailure('Failed to create user: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(User user) async {
    try {
      final model = UserModel.fromEntity(user);
      await localDataSource.updateUser(model);
      return Either.right(null);
    } catch (e) {
      return Either.left(ServerFailure('Failed to update user: $e'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final models = await localDataSource.getUsers();
      final users = models.map((model) => model.toEntity()).toList();
      return Either.right(users);
    } catch (e) {
      return Either.left(ServerFailure('Failed to get users: $e'));
    }
  }
}
