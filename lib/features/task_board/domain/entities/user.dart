import 'package:equatable/equatable.dart';

import '../../../shared/enum/enum.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final Role role;

  const User({
    //TODO: Need to check for auto increment during local storage integration 
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  List<Object> get props => [id, name, email, role];
}
