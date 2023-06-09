import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/service/user_service.dart';

import 'db_service.dart';

class AuthService {
  static const String table = 'tb_auth';
  final dbInstance = DBService.instance;

  Future<UserModel?> getLoggedIn() async {
    final db = await dbInstance.database;

    final result = await db.query(table);

    if (result.isEmpty || result.first['user'] == null) {
      return null;
    } else {
      return await UserService().get(result.first['user'] as int);
    }
  }

  Future<bool> logIn({
    required String username,
    required String password,
    bool updateAuth = true,
  }) async {
    print("username: $username");
    print("password: $password");

    try {
      List<UserModel> matchedUser = List.empty(growable: true);
      final allUsers = await UserService().getAll();

      for (var user in allUsers) {
        if (user.username == username) {
          if (user.password == password) {
            matchedUser.add(user);
          }
        }
      }

      if (matchedUser.isEmpty) {
        return false;
      } else {
        if (updateAuth) {
          // insert to db
          final db = await DBService.instance.database;
          final result = await db.insert(table, {'user': matchedUser.first.id});

          print('Log In: $result');
          print('User Logged In: ${matchedUser.first}');
        }

        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      final db = await dbInstance.database;
      await db.rawDelete("DELETE FROM $table");

      return true;
    } catch (e) {
      print(e.toString());

      return false;
    }
  }
}
