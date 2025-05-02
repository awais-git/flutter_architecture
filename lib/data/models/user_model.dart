import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@HiveType(typeId: 0)
class UserModel with _$UserModel {
  @HiveField(0)
  const factory UserModel({
    @HiveField(1) required int id,
    @HiveField(2) required String name,
    @HiveField(3) required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}