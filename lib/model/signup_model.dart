import 'package:hive_flutter/adapters.dart';
part 'signup_model.g.dart';

@HiveType(typeId: 0)
class SignupModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String emailId;

  @HiveField(2)
  final String password;

  const SignupModel(this.name, this.emailId, this.password);
}
