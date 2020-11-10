class Building {
  int id;
  String shortName;
  String fullName;
  String description;
  String address;

  Building(
      {this.id, this.shortName, this.fullName, this.description, this.address});

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json['id'],
        shortName: json['shortName'],
        fullName: json['fullName'],
        description: json['description'],
        address: json['address'],
      );

  @override
  String toString() {
    return 'Building{id: $id, shortName: $shortName, fullName: $fullName, description: $description, address: $address}';
  }
}
