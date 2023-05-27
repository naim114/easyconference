import 'package:easyconference/model/user_model.dart';

class ConferenceModel {
  final int id;
  final String name;
  final DateTime dateTime;
  final String desc;
  final String? posterPath;
  final UserModel presenter;

  ConferenceModel({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.desc,
    this.posterPath,
    required this.presenter,
  });

  @override
  String toString() {
    return 'ConferenceModel(id: $id, name: $name, dateTime: $dateTime, desc: $desc, posterPath: $posterPath, presenter: $presenter)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateTime': dateTime,
      'desc': desc,
      'posterPath': posterPath,
      'presenter': presenter.id,
    };
  }
}
