import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.name,
    required super.email,
    required super.role,
  });
}
