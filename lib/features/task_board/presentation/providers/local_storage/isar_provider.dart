import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';

final isarProvider = FutureProvider((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([TaskModelSchema, UserModelSchema], directory: dir.path);
});
