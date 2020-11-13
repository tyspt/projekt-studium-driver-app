class Handover {
  String uuid;
  String createdTimestamp;
  String lastUpdatedTimestamp;
  HandoverStatus status;

  Handover(
      {this.uuid,
      this.createdTimestamp,
      this.lastUpdatedTimestamp,
      this.status});

  factory Handover.fromJson(Map<String, dynamic> json) => Handover(
        uuid: json['uuid'],
        createdTimestamp: json['createdTimestamp'],
        lastUpdatedTimestamp: json['lastUpdatedTimestamp'],
        status: handoverStatusFromJson(json['status']),
      );

  @override
  String toString() {
    return 'Handover{uuid: $uuid, createdTimestamp: $createdTimestamp, lastUpdatedTimestamp: $lastUpdatedTimestamp, status: $status}';
  }
}

HandoverStatus handoverStatusFromJson(String strValue) {
  return HandoverStatus.values.firstWhere(
      (status) => status.toString().split(".").last == strValue,
      orElse: () => null);
}

enum HandoverStatus { ON_GOING, CANCELED, COMPLETED }
