
import 'package:flutter_structure/data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
}

class UserEntity {
  final int id;
  final String name;
  final String email;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
}