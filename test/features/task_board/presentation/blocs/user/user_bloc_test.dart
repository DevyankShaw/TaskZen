import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taskzen/features/shared/error/failure.dart';
import 'package:taskzen/features/shared/mock/mock_data.dart';
import 'package:taskzen/features/task_board/domain/usecases/user/create_all_users.dart';
import 'package:taskzen/features/task_board/domain/usecases/user/create_user.dart';
import 'package:taskzen/features/task_board/domain/usecases/user/get_user_by_id.dart';
import 'package:taskzen/features/task_board/domain/usecases/user/get_users.dart';
import 'package:taskzen/features/task_board/domain/usecases/user/update_user.dart';
import 'package:taskzen/features/task_board/domain/usecases/user/user_use_cases.dart';
import 'package:taskzen/features/task_board/presentation/blocs/user/user_bloc.dart';

/// Unit test against below events written as it's been used in feature
/// - LoadUsersEvent
/// - AddAllUsersEvent
///
///
/// Unit test against below events not written as it's not been used in feature
/// - AddUserEvent
/// - UpdateUserEvent
/// - GetUserByIdEvent

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockGetUserById extends Mock implements GetUserById {}

class MockCreateAllUsers extends Mock implements CreateAllUsers {}

void main() {
  late UserBloc userBloc;
  late UserUseCases userUseCases;
  late MockGetUsers mockGetUsers;
  late MockCreateUser mockCreateUser;
  late MockUpdateUser mockUpdateUser;
  late MockGetUserById mockGetUserById;
  late MockCreateAllUsers mockCreateAllUsers;

  setUp(() {
    mockGetUsers = MockGetUsers();
    mockCreateUser = MockCreateUser();
    mockUpdateUser = MockUpdateUser();
    mockGetUserById = MockGetUserById();
    mockCreateAllUsers = MockCreateAllUsers();
    userUseCases = UserUseCases(
      getUsers: mockGetUsers,
      createUser: mockCreateUser,
      updateUser: mockUpdateUser,
      getUserById: mockGetUserById,
      createAllUsers: mockCreateAllUsers,
    );

    userBloc = UserBloc(userUseCases);
  });

  test('initial State should be UserLoading', () {
    expect(userBloc.state, equals(UserLoading()));
  });

  group('LoadUsersEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when LoadUsersEvent is fetched and success',
      build: () {
        when(
          () => userUseCases.getUsers(),
        ).thenAnswer((_) async => Either.right(mockUserList));
        return userBloc;
      },
      act: (bloc) => bloc.add(LoadUsersEvent()),
      expect: () => [UserLoading(), UserLoaded(mockUserList)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when LoadUsersEvent is fetched and fail',
      build: () {
        when(() => userUseCases.getUsers()).thenAnswer(
          (_) async => Either.left(ServerFailure('Failed to get users')),
        );
        return userBloc;
      },
      act: (bloc) => bloc.add(LoadUsersEvent()),
      expect: () => [UserLoading(), UserError('Failed to get users')],
    );
  });

  group('AddAllUsersEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when AddAllUsersEvent is added and success',
      build: () {
        when(
          () => userUseCases.getUsers(),
        ).thenAnswer((_) async => Either.right(mockUserList));
        when(
          () => userUseCases.createAllUsers(mockUserList),
        ).thenAnswer((_) async => Either.right(null));
        return userBloc;
      },
      act: (bloc) => bloc.add(AddAllUsersEvent(mockUserList)),
      expect: () => [UserLoading(), UserLoaded(mockUserList)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserError] when AddAllUsersEvent is added and fail',
      build: () {
        when(() => userUseCases.createAllUsers(mockUserList)).thenAnswer(
          (_) async => Either.left(ServerFailure('Failed to add user')),
        );
        return userBloc;
      },
      act: (bloc) => bloc.add(AddAllUsersEvent(mockUserList)),
      expect: () => [UserError('Failed to add user')],
    );
  });
}
