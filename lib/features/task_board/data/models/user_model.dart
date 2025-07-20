import 'package:isar/isar.dart';

import '../../../shared/enum/enum.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  final Id id;
  final String name;
  final String email;
  @enumerated
  final Role role;

  UserModel({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    name: user.name,
    email: user.email,
    role: user.role,
  );

  User toEntity() {
    return User(id: id, name: name, email: email, role: role);
  }
}
