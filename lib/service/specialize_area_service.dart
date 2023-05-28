import 'package:easyconference/model/specialize_area_model.dart';

import 'db_service.dart';

class SpecializeAreaService {
  static const String table = 'tb_specialize_area';
  final dbInstance = DBService.instance;

  Future<List<SpecializeAreaModel>> getAll() async {
    final db = await dbInstance.database;

    final result = await db.query(table);

    print("result: $result");

    return result.map((json) => SpecializeAreaModel.fromJson(json)).toList();
  }

  Future<SpecializeAreaModel?> get(int id) async {
    final List<SpecializeAreaModel> all =
        await SpecializeAreaService().getAll();

    SpecializeAreaModel? result;

    for (var element in all) {
      if (element.id == id) {
        result = element;
        break;
      }
    }

    return result;
  }

  Future<SpecializeAreaModel?> getByArea(String area) async {
    final List<SpecializeAreaModel> all =
        await SpecializeAreaService().getAll();

    SpecializeAreaModel? result;

    for (var element in all) {
      if (element.area == area) {
        result = element;
        break;
      }
    }

    print("getByArea: $result");

    return result;
  }

  Future insert({required SpecializeAreaModel special}) async {
    try {
      final db = await dbInstance.database;
      final result = await db.insert(table, special.toMap());
      print('Add SpecializeArea: $result');

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
