class Package {
  String id;
  String type;
  String barcode;
  String orderNumber;
  Person recipient;
  Person representative;
  Person sender;
  String timeCreated;
  Status status;
}

class Person {
  String name;
  String email;
  String employeeId;
  String telephone;
  String building;
  String fullAddress;
}

enum Type { INBOUND, OUTBOUND }

enum Status {
  ERFASST,
  SORTIERT,
  IM_TRANSPORT,
  GELIEFERT,
}
