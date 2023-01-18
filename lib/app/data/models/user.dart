import 'package:resourcer/data/abstracts/resource.dart';
import 'package:resourcer/widgets/resource_table_view.dart';

class User extends Resource<User> {
  @override
  final int? id;
  @override
  String? get name => username;

  String? username;
  String? password;

  User({
    this.id,
    this.username,
    this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      if (password != null) 'password': password!,
    };
  }

  @override
  User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field("username", FieldType.name, label: "Username", isRequired: true),
      Field("password", FieldType.password,
          label: "Password", isRequired: id == null),
    ];
  }

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(columns: []);
  }

  @override
  ResourceRow getResourceRow(TableController<Resource> controller) {
    return ResourceRow(cells: []);
  }

  @override
  bool get isEmpty => id == null;
}
