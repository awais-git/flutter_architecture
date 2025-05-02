import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_structure/data/datasources/local/user_local_data_source.dart';
import 'package:hive/hive.dart';
import '../../models/user_model.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<UserModel> userBox;

  UserLocalDataSourceImpl(this.userBox);

  @override
  Future<List<UserModel>> getCachedUsers() async {
    return userBox.values.toList();
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    await userBox.clear();
    for (var user in users) {
      await userBox.put(user.id, user);
    }
  }
}

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  final box = Hive.box<UserModel>('users');
  return UserLocalDataSourceImpl(box);
});