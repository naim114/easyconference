import 'dart:convert';
import 'dart:typed_data';

import 'package:easyconference/model/conference_model.dart';
import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/service/user_service.dart';
import 'package:intl/intl.dart';

import 'db_service.dart';

class ConferenceService {
  static const String table = 'tb_conference';
  final dbInstance = DBService.instance;

  Future<ConferenceModel> fromJson(Map<String, dynamic> map) async {
    return ConferenceModel(
      id: map['id'],
      name: map['name'],
      dateTime: DateFormat("dd/MM/yyyy hh:mm a").parse(map['dateTime']),
      desc: map['desc'],
      posterBytes: map['posterBytes'],
      presenter: await UserService().get(map['presenter']),
    );
  }

  Future<List<ConferenceModel>> getAll() async {
    final db = await dbInstance.database;

    final result = await db.query(table);

    final futures = result.map((json) => ConferenceService().fromJson(json));

    return Future.wait(futures.toList());
  }

  Future<ConferenceModel> get(int id) async {
    final List<ConferenceModel> all = await ConferenceService().getAll();

    ConferenceModel? result;

    for (var element in all) {
      if (element.id == id) {
        result = element;
        break;
      }
    }

    return result!;
  }

  Future<List<ConferenceModel>> getByUser(UserModel user) async {
    final List<ConferenceModel> all = await ConferenceService().getAll();
    final List<ConferenceModel> matched = List.empty(growable: true);

    for (var element in all) {
      if (element.presenter.id == user.id) {
        matched.add(element);
      }
    }

    return matched;
  }

  Future insert({required ConferenceModel data}) async {
    try {
      final db = await DBService.instance.database;
      final result = await db.insert(table, data.toMap());
      print('Add Conference: $result');

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> add({
    required String name,
    required String dateTime,
    required String desc,
    Uint8List? posterBytes,
    required UserModel presenter,
  }) async {
    try {
      final db = await DBService.instance.database;
      final result = await db.insert(table, {
        'name': name,
        'dateTime': dateTime,
        'desc': desc,
        'posterBytes': posterBytes == null ? null : base64Encode(posterBytes),
        'presenter': presenter.id,
      });
      print('Add Conference: $result');

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> edit({
    required ConferenceModel conference,
    required String name,
    required String dateTime,
    required String desc,
    Uint8List? posterBytes,
    required UserModel presenter,
  }) async {
    try {
      final db = await DBService.instance.database;

      final result = await db.update(
        table,
        {
          'name': name,
          'dateTime': dateTime,
          'desc': desc,
          'posterBytes': posterBytes == null ? null : base64Encode(posterBytes),
          'presenter': presenter.id,
        },
        where: 'id = ?',
        whereArgs: [conference.id],
      );

      print('Edit Conference: $result');

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> delete(ConferenceModel conference) async {
    try {
      final db = await dbInstance.database;
      final result = await db.delete(
        table,
        where: 'id = ?',
        whereArgs: [conference.id],
      );

      print('Delete Conference: $result');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
