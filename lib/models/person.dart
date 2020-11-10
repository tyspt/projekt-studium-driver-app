import 'package:projekt_studium_driver_app/models/building.dart';

class Person {
  int id;
  String name;
  String email;
  String telephone;
  Building building;
  String fullAddress;
  Person representative;

  Person({
    this.id,
    this.name,
    this.email,
    this.telephone,
    this.fullAddress,
    this.building,
    this.representative,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      telephone: json['telephone'],
      fullAddress: json['fullAddress'],
      building: Building.fromJson(json['building']),
      representative: json['representative'] == null
          ? null
          : Person.fromJson(json['representative']));

  @override
  String toString() {
    return 'Person{id: $id, name: $name, email: $email, telephone: $telephone, building: $building, fullAddress: $fullAddress, representative: $representative}';
  }
}
