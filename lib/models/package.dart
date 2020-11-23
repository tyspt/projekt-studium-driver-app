import 'package:projekt_studium_driver_app/models/employee.dart';

class Package {
  int id;
  PackageType type;
  String barcode;
  String orderNumber;
  Employee recipient;
  Employee sender;
  String createdTimestamp;
  String lastUpdatedTimestamp;
  PackageStatus status;

  Package(
      {this.id,
      this.type,
      this.barcode,
      this.orderNumber,
      this.recipient,
      this.sender,
      this.createdTimestamp,
      this.lastUpdatedTimestamp,
      this.status});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      type: packageTypeFromJson(json['type']),
      barcode: json['barcode'],
      orderNumber: json['orderNumber'],
      createdTimestamp: json['createdTimestamp'],
      lastUpdatedTimestamp: json['lastUpdatedTimestamp'],
      status: packageStatusFromJson(json['status']),
      recipient: Employee.fromJson(json['recipient']),
      sender: Employee.fromJson(json['sender']),
    );
  }

  @override
  String toString() {
    return 'Package{id: $id, type: $type, barcode: $barcode, orderNumber: $orderNumber, recipient: $recipient, sender: $sender, createdTimestamp: $createdTimestamp, lastUpdatedTimestamp: $lastUpdatedTimestamp, status: $status}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Package && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

PackageStatus packageStatusFromJson(String strValue) {
  return PackageStatus.values.firstWhere(
      (status) => status.toString().split(".").last == strValue,
      orElse: () => null);
}

PackageType packageTypeFromJson(String strValue) {
  return PackageType.values.firstWhere(
      (type) => type.toString().split(".").last == strValue,
      orElse: () => null);
}

enum PackageType { INBOUND, OUTBOUND }

enum PackageStatus {
  CREATED,
  IN_HANDOVER,
  IN_TRANSPORT,
  REATTEMPT_DELIVERY,
  DELIVERED,
  NOT_DELIVERABLE,
  RECEIVED_BY_LC
}
