import 'package:hive/hive.dart';
import 'package:login_register/view/LoginPage.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  User({required this.username, required this.password});
}
