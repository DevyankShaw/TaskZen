import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/user/user_use_cases.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCases useCases;

  UserBloc(this.useCases) : super(UserLoading()) {
    on<LoadUsersEvent>(_onLoad);
    on<AddUserEvent>(_onAdd);
    on<UpdateUserEvent>(_onUpdate);
    on<GetUserByIdEvent>(_onLoadUserById);
    on<AddAllUsersEvent>(_onAddAll);
  }

  Future<void> _onLoad(LoadUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await useCases.getUsers();
    emit(
      result.fold(
        (fail) => UserError(fail.message),
        (users) => UserLoaded(users),
      ),
    );
  }

  Future<void> _onAdd(AddUserEvent event, Emitter<UserState> emit) async {
    final result = await useCases.createUser(event.user);
    result.fold(
      (fail) => emit(UserError(fail.message)),
      (_) => add(LoadUsersEvent()),
    );
  }

  Future<void> _onUpdate(UpdateUserEvent event, Emitter<UserState> emit) async {
    final result = await useCases.updateUser(event.user);
    result.fold(
      (fail) => emit(UserError(fail.message)),
      (_) => add(LoadUsersEvent()),
    );
  }

  Future<void> _onLoadUserById(
    GetUserByIdEvent event,
    Emitter<UserState> emit,
  ) async {
    final result = await useCases.getUserById(event.userId);
    emit(
      result.fold(
        (fail) => UserError(fail.message),
        (user) => SingleUserLoaded(user),
      ),
    );
  }

  Future<void> _onAddAll(AddAllUsersEvent event, Emitter<UserState> emit) async {
    final result = await useCases.createAllUsers(event.users);
    result.fold(
      (fail) => emit(UserError(fail.message)),
      (_) => add(LoadUsersEvent()),
    );
  }
}
