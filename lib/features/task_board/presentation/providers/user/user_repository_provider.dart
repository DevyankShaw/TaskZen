import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/user_repository_impl.dart';
import '../../../data/sources/local_data_source.dart';
import '../../../domain/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(LocalDataSource());
});
