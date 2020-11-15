class Driver {
  int id;
  String name;
  String email;
  String telephone;
  String company;

  // Last known GPS location
  double latitude;
  double longitude;
  double accuracy;
  String lastUpdatedTimestamp;

  Driver(
      {this.id,
      this.name,
      this.email,
      this.telephone,
      this.company,
      this.latitude,
      this.longitude,
      this.accuracy,
      this.lastUpdatedTimestamp});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        telephone: json['telephone'],
        company: json['company'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        accuracy: json['accuracy'],
        lastUpdatedTimestamp: json['lastUpdatedTimestamp'],
      );

  @override
  String toString() {
    return 'Driver{id: $id, name: $name, email: $email, telephone: $telephone, company: $company, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, lastUpdatedTimestamp: $lastUpdatedTimestamp}';
  }
}
