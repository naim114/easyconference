import 'package:easyconference/model/specialize_area_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final int phone;
  final String role;
  final String username;
  final String password;
  final String? avatarBytes;
  final SpecializeAreaModel? specializeArea;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.username,
    required this.password,
    this.avatarBytes,
    this.specializeArea,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, role: $role, username: $username, password: $password, avatarPath: $avatarBytes, specializeArea: $specializeArea)';
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
      'avatarPath': avatarBytes,
      'specializeArea': specializeArea == null ? null : specializeArea!.id,
    };
  }
}
