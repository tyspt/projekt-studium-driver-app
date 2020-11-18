import 'package:projekt_studium_driver_app/models/building.dart';

class Employee {
  int id;
  String name;
  String email;
  String telephone;
  Building building;
  String fullAddress;
  Employee representative;

  Employee({
    this.id,
    this.name,
    this.email,
    this.telephone,
    this.fullAddress,
    this.building,
    this.representative,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      telephone: json['telephone'],
      fullAddress: json['fullAddress'],
      building:
          json['building'] == null ? null : Building.fromJson(json['building']),
      representative: json['representative'] == null
          ? null
          : Employee.fromJson(json['representative']));

  @override
  String toString() {
    return 'Employee{id: $id, name: $name, email: $email, telephone: $telephone, building: $building, fullAddress: $fullAddress, representative: $representative}';
  }
}
