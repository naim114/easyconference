import 'package:easyconference/model/specialize_area_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final int phone;
  final String role;
  final String username;
  final String password;
  final String institute;
  final String? avatarBytes;
  final SpecializeAreaModel? specializeArea;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.username,
    required this.password,
    required this.institute,
    this.avatarBytes,
    this.specializeArea,
    this.isAdmin = false,
  });

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, role: $role, username: $username, password: $password, avatarBytes: $avatarBytes, specializeArea: $specializeArea, isAdmin: $isAdmin, institute: $institute)';
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
      'avatarBytes': avatarBytes,
      'specializeArea': specializeArea == null ? null : specializeArea!.id,
      'isAdmin': isAdmin ? '1' : '0',
      'institute': institute,
    };
  }
}
