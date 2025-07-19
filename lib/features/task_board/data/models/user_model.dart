import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.name,
    required super.email,
    required super.role,
  });

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    name: user.name,
    email: user.email,
    role: user.role,
  );

  User toEntity() {
    return this;
  }
}
