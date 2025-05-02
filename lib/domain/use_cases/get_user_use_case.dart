import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_structure/data/models/user_model.dart';
import 'package:flutter_structure/data/repositories/user_repository_impl.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<List<UserModel>> execute() async {
    return await repository.getUsers();
  }
}

final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) {
  return GetUsersUseCase(ref.read(userRepositoryProvider));
});