import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/user_repository_impl.dart';
import '../../../data/sources/local_data_source.dart';
import '../../../domain/repositories/user_repository.dart';
import '../local_storage/isar_provider.dart';

final userRepositoryProvider = FutureProvider<UserRepository>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return UserRepositoryImpl(LocalDataSource(isar));
});
