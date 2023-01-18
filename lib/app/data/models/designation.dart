import 'package:resourcer/resourcer.dart';

class Designation extends Resource {
  @override
  int? id;
  @override
  String? name;
  int? employeesCount;

  Designation({
    this.id,
    this.name,
    this.employeesCount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employees_count': employeesCount,
    };
  }

  @override
  String toString() {
    return 'Designation{id: $id, name: $name, employeesCount: $employeesCount}';
  }

  String getName() {
    return name ?? "-";
  }

  int getEmployeesCount() {
    return employeesCount ?? 0;
  }

  bool get hasEmployees => (employeesCount ?? 0) > 0;

  @override
  Designation fromMap(Map<String, dynamic> map) {
    return Designation(
      id: map['id'],
      name: map['name'],
      employeesCount: int.parse((map['employees_count'] ?? 0).toString()),
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field("name", FieldType.name, isRequired: true, label: "Name"),
    ];
  }

  @override
  ResourceColumn getResourceColumn() {
    // TODO: implement getResourceColumn
    throw UnimplementedError();
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    // TODO: implement getResourceRow
    throw UnimplementedError();
  }

  @override
  bool get isEmpty => id == null;
}
