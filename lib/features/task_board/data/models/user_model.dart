import '../../../shared/enum/enum.dart';
import '../../domain/entities/user.dart';

class UserModel {
  late int userId;
  late String name;
  late String email;
  late Role role;

  UserModel({
    //TODO: Remove once local storage integrated
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
  });

  UserModel.fromEntity(User user) {
    userId = user.id;
    name = user.name;
    email = user.email;
    role = user.role;
  }

  User toEntity() {
    return User(id: userId, name: name, email: email, role: role);
  }
}
