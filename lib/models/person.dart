class Person {
  String id;
  String name;
  String email;
  String telephone;
  String building; // TODO
  String fullAddress;
  Person representative;

  Person({
    this.id,
    this.name,
    this.email,
    this.telephone,
    this.fullAddress,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      telephone: json['telephone'],
      fullAddress: json['fullAddress'],
    );
  }
}
