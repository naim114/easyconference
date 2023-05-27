import 'package:easyconference/model/specialize_area_model.dart';
import 'package:easyconference/service/specialize_area_service.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final int phone;
  final String role;
  final String username;
  final String password;
  final String? avatarPath;
  final SpecializeAreaModel? specializeArea;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.username,
    required this.password,
    this.avatarPath,
    this.specializeArea,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, role: $role, username: $username, password: $password, avatarPath: $avatarPath, specializeArea: $specializeArea)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'username': username,
      'password': password,
      'avatarPath': avatarPath,
      'specializeArea': specializeArea == null ? null : specializeArea!.id,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      username: map['username'],
      password: map['password'],
      avatarPath: map['avatarPath'],
    );
  }

  static Future<UserModel> fromJsonAsync(Map<String, dynamic> map) async {
    final specializeArea =
        await SpecializeAreaService().get(map['specializeArea']);

    return UserModel.fromJson(map).copyWith(specializeArea: specializeArea);
  }

  UserModel copyWith({SpecializeAreaModel? specializeArea}) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      role: role,
      username: username,
      password: password,
      avatarPath: avatarPath,
      specializeArea: specializeArea ?? this.specializeArea,
    );
  }
}
