import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_structure/core/network/api_client.dart';
import 'package:flutter_structure/main.dart';

import '../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<UserModel>> getUsers() async {
    // This is just an example - replace with your actual API endpoint
    final response = await apiClient.get('https://jsonplaceholder.typicode.com/users');
    return (response as List).map((user) => UserModel.fromJson(user)).toList();
  }
}

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>(
  (ref) {
    return UserRemoteDataSourceImpl(
      ApiClient(ref.read(dioProvider)),
    );
  },
);
