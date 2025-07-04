import 'package:isar/isar.dart';

import '../../../shared/enum/enum.dart';

part 'user.g.dart';

@collection
class User {
  final Id id;
  final String name;
  final String email;
  @enumerated
  final Role role;

  const User({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.email,
    required this.role,
  });
}
