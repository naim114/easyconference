class SpecializeAreaModel {
  final int id;
  final String area;

  SpecializeAreaModel({
    required this.id,
    required this.area,
  });

  @override
  String toString() {
    return 'SpecializeAreaModel(id: $id,area: $area)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area,
    };
  }
}
