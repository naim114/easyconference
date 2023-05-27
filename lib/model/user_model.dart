import 'package:easyconference/model/specialize_area_model.dart';

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
      'specializeArea': specializeArea!.id,
    };
  }
}
