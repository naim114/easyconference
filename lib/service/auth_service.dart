import 'package:easyconference/model/user_model.dart';

import 'db_service.dart';

class AuthService {
  static const String table = 'tb_auth';
  final dbInstance = DBService.instance;

// TODO
  Future<void> getLoggedIn() async {
    final db = await dbInstance.database;

    final result = await db.query(table);

    print(result);
  }
}
