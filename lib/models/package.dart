import 'package:projekt_studium_driver_app/models/person.dart';

class Package {
  String id;
  String type;
  String barcode;
  String orderNumber;
  Person recipient;
  Person sender;
  Person representative;
  String createdTimestamp;
  String lastUpdatedTimestamp;
  PackageStatus status;

  Package(
      {this.id,
      this.type,
      this.barcode,
      this.orderNumber,
      this.recipient, //TODO
      this.sender, // TODO
      this.representative, //TODO
      this.createdTimestamp,
      this.lastUpdatedTimestamp,
      this.status});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      type: json['type'],
      barcode: json['barcode'],
      orderNumber: json['orderNumber'],
      createdTimestamp: json['createdTimestamp'],
      lastUpdatedTimestamp: json['lastUpdatedTimestamp'],
      status: json['status'],
    );
  }
}

enum PackageType { INBOUND, OUTBOUND }

enum PackageStatus {
  CREATED,
  IN_HANDOVER,
  IN_TRANSPORT,
  REATTEMPT_DELIVERY,
  DELIVERED,
  NOT_DELIVERABLE,
  COLLECTED,
  RECEIVED_BY_LOGISTIC_CENTER
}
