import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/entities/user.dart';

final isarProvider = FutureProvider((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([TaskSchema, UserSchema], directory: dir.path);
});