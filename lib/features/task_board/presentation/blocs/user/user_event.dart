part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsersEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final User user;
  AddUserEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class UpdateUserEvent extends UserEvent {
  final User user;
  UpdateUserEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class GetUserByIdEvent extends UserEvent {
  final int userId;
  GetUserByIdEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class AddAllUsersEvent extends UserEvent {
  final List<User> users;
  AddAllUsersEvent(this.users);
  @override
  List<Object?> get props => [users];
}