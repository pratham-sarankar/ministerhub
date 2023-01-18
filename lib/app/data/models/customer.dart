import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ministerhub/app/data/repositories/file_repository.dart';
import 'package:resourcer/resourcer.dart';

class Customer extends Resource {
  @override
  final int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? photoUrl;
  String? email;
  String? phoneNumber;
  String? password;
  DateTime? dob;
  int? branchId;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.photoUrl,
    this.email,
    this.phoneNumber,
    this.password,
    this.dob,
    this.branchId,
  });

  @override
  bool operator ==(Object other) => (other is Customer) && id == other.id;

  @override
  int get hashCode => id.hashCode;

  bool get hasPhoto => photoUrl != null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'photoUrl': photoUrl,
      'email': email,
      'phoneNumber': phoneNumber,
      'branch_id': branchId,
      if (password != null) 'password': password,
      'dob': dob == null ? null : getDateOfBirth(),
    };
  }

  @override
  Customer fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      branchId: map['branch_id'],
      dob: map['dob'] == null ? null : setDateOfBirth(map['dob']),
    );
  }

  DateTime setDateOfBirth(String data) {
    var date = DateTime.tryParse(data);
    date ??= DateFormat('d MMM y').parse(data);
    return date;
  }

  String? getPhotoUrl() {
    if (photoUrl == null) return null;
    return FileRepository.instance.getUrl(photoUrl!);
  }

  String getEmail() {
    return email ?? "-";
  }

  String getPhoneNumber() {
    return phoneNumber ?? "-";
  }

  String getDateOfBirth() {
    return dob == null ? "-" : DateFormat('d MMM y').format(dob!);
  }

  @override
  String toString() {
    return 'Customer{id: $id, firstName: $firstName, lastName: $lastName, username: $username, photoUrl: $photoUrl, email: $email, phoneNumber: $phoneNumber, dob: $dob}';
  }

  @override
  String get name => "${firstName ?? ""} ${lastName ?? ""}";

  @override
  bool get isEmpty => id == null;

  @override
  ResourceColumn getResourceColumn() {
    return ResourceColumn(
      columns: [
        "Username",
        "Name",
        "Email",
        "Phone number",
        "Date of birth",
      ],
    );
  }

  @override
  ResourceRow getResourceRow(TableController controller) {
    return ResourceRow(
      cells: [
        Cell(
          data: getPhotoUrl(),
          children: [
            Cell(data: username),
          ],
        ),
        Cell(data: "${firstName ?? ""} ${lastName ?? ""}"),
        Cell(data: getEmail()),
        Cell(data: getPhoneNumber()),
        Cell(data: getDateOfBirth()),
        Cell(children: [
          Cell(
            isAction: true,
            icon: Icons.edit,
            data: "Edit",
            onPressed: () {
              controller.updateRow(this);
            },
          ),
          Cell(
            isAction: true,
            icon: Icons.delete,
            data: "Delete",
            onPressed: () {
              controller.destroyRow(this);
            },
          ),
        ]),
      ],
    );
  }

  @override
  List<Field> getFields() {
    return [
      Field("photoUrl", FieldType.image, label: "Profile Photo"),
      Field("firstName", FieldType.name, label: "First Name"),
      Field("lastName", FieldType.name, label: "Last Name"),
      Field("username", FieldType.name, label: "Username", isSearchable: true),
      Field("email", FieldType.email, label: "Email", isSearchable: true),
      Field("dob", FieldType.date, label: "Date of Birth"),
      Field("phoneNumber", FieldType.phoneNumber,
          label: "Contact Number", isSearchable: true),
      Field("password", FieldType.password,
          label: "Password", isRequired: isEmpty),
    ];
  }

  @override
  Future<String> fileUploader(Uint8List data) =>
      FileRepository.instance.imageUploader(data);

  @override
  Future<Uint8List> fileDownloader(String key) =>
      FileRepository.instance.imageDownloader(key);
}
