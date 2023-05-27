import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/service/db_service.dart';

class UserService {
  static const String table = 'tb_user';
  final dbInstance = DBService.instance;

  Future<List<UserModel>> getAll() async {
    final db = await dbInstance.database;

    final result = await db.query(table);

    return result.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel> get(int id) async {
    final List<UserModel> all = await UserService().getAll();

    UserModel? result;

    for (var element in all) {
      if (element.id == id) {
        result = element;
        break;
      }
    }

    return result!;
  }

  Future insert({required UserModel user}) async {
    try {
      final db = await DBService.instance.database;
      final result = await db.insert(table, user.toMap());
      print('Add User: $result');

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
