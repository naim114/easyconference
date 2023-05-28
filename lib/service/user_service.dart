import 'dart:convert';
import 'dart:typed_data';

import 'package:easyconference/model/specialize_area_model.dart';
import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/service/db_service.dart';
import 'package:easyconference/service/specialize_area_service.dart';

class UserService {
  static const String table = 'tb_user';
  final dbInstance = DBService.instance;

  Future<UserModel> fromJson(Map<String, dynamic> map) async {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      username: map['username'],
      password: map['password'],
      avatarBytes: map['avatarPath'],
      specializeArea: map['specializeArea'] == null
          ? null
          : await SpecializeAreaService().get(map['specializeArea']),
    );
  }

  Future<List<UserModel>> getAll() async {
    final db = await dbInstance.database;

    final result = await db.query(table);

    final futures = result.map((json) => UserService().fromJson(json));

    return Future.wait(futures.toList());
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

  Future signUp({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String username,
    required String password,
    String? avatarPath,
    SpecializeAreaModel? specializeArea,
  }) async {
    try {
      final db = await DBService.instance.database;
      final result = await db.insert(
        table,
        {
          'name': name,
          'email': email,
          'phone': phone,
          'role': role,
          'username': username,
          'password': password,
          'avatarPath': avatarPath,
          'specializeArea': specializeArea?.id,
        },
      );

      print('Sign Up User: $result');

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future update({
    required UserModel user,
    required String name,
    required String email,
    required String phone,
    required String role,
    SpecializeAreaModel? specializeArea,
  }) async {
    try {
      final db = await DBService.instance.database;
      db.update(
        table,
        {
          'name': name,
          'email': email,
          'phone': phone,
          'role': role,
          'specializeArea': specializeArea?.id,
        },
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future updateAuth({
    required UserModel user,
    required String newUsername,
    required String newPassword,
  }) async {
    try {
      final db = await DBService.instance.database;
      db.update(
        table,
        {
          'username': newUsername,
          'password': newPassword,
        },
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateAvatar({
    required UserModel user,
    required Uint8List avatar,
  }) async {
    try {
      final db = await DBService.instance.database;
      db.update(
        table,
        {
          'avatarPath': base64Encode(avatar),
        },
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> removeAvatar({required UserModel user}) async {
    try {
      final db = await DBService.instance.database;
      db.update(
        table,
        {
          'avatarPath': null,
        },
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
