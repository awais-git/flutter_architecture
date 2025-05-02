import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_structure/data/datasources/local/user_local_data_source_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../datasources/local/user_local_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      await localDataSource.cacheUsers(users);
      return users;
    } catch (e) {
      final cachedUsers = await localDataSource.getCachedUsers();
      if (cachedUsers.isNotEmpty) {
        return cachedUsers;
      }
      rethrow;
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    remoteDataSource: ref.read(userRemoteDataSourceProvider),
    localDataSource: ref.read(userLocalDataSourceProvider),
  );
});