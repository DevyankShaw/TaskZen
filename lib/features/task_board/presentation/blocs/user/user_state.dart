part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
  @override
  List<Object?> get props => [users];
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
  @override
  List<Object?> get props => [message];
}

class SingleUserLoaded extends UserState {
  final User? user;
  SingleUserLoaded(this.user);
  @override
  List<Object?> get props => [user];
}
