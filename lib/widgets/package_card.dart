import 'package:dart_casing/dart_casing.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/services/package_service.dart';

class PackageListItem extends StatelessWidget {
  final Package package;

  PackageListItem(this.package);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Theme.of(context).primaryColor.withAlpha(30),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => PackageDetailPopupDialog(this.package));
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // Left Avatar section
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Text(package.recipient.building.shortName),
                ),
                const SizedBox(width: 16),
                // Right Text & Status section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Casing.titleCase(package.recipient.name),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '#' + package.barcode,
                              ),
                              Text(package.createdTimestamp,
                                  textScaleFactor: 0.9,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ],
                          ),
                          Spacer(),
                          PackageStatusChip(package.status),
                        ],
                      ),
                      Text(
                        package.recipient.fullAddress,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class PackageDetailPopupDialog extends StatelessWidget {
  final Package package;

  PackageDetailPopupDialog(this.package);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Package #" + package.id.toString()),
      children: [
        Center(
          child: Column(
            children: [
              DetailRow('Tracking Number:', Text(package.barcode ?? 'N/A')),
              DetailRow('Order Number:', Text(package.orderNumber ?? 'N/A')),
              DetailRow(
                  'Type:',
                  Text(Casing.titleCase(
                      EnumToString.convertToString(package.type)))),
              DetailRow(
                  'Recipient Name:', Text(package.recipient.name ?? 'N/A')),
              DetailRow('Email:', Text(package.recipient.email ?? 'N/A')),
              DetailRow(
                  'Telephone:', Text(package.recipient.telephone ?? 'N/A')),
              DetailRow('Building:',
                  Text(package.recipient.building.shortName ?? 'N/A')),
              DetailRow(
                  'Address:', Text(package.recipient.fullAddress ?? 'N/A')),
              DetailRow('Representative:',
                  Text(package.recipient.representative?.name ?? 'N/A')),
              DetailRow('Sender:', Text(package.sender.name ?? 'N/A')),
              DetailRow(
                  'Time Created:', Text(package.createdTimestamp ?? 'N/A')),
              DetailRow(
                  'Last Updated:', Text(package.lastUpdatedTimestamp ?? 'N/A')),
              DetailRow('Status:', PackageStatusChip(package.status)),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text(
                      'Deliver Package',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      PackageService.updatePackageStatus(
                          package.id.toString(), PackageStatus.IN_HANDOVER);
                    },
                    child: Text(
                      'Not Deliverable',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String header;
  final Widget content;

  DetailRow(this.header, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(this.header,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child:
                Container(alignment: Alignment.centerLeft, child: this.content),
          ),
        ],
      ),
    );
  }
}

class PackageStatusChip extends StatelessWidget {
  final PackageStatus status;

  PackageStatusChip(this.status);

  Color _getStatusChipColor(PackageStatus status) {
    switch (status) {
      case PackageStatus.CREATED:
        return Color(0xff53da72);
      case PackageStatus.IN_HANDOVER:
        return Color(0xffd2b9ff);
      case PackageStatus.IN_TRANSPORT:
      case PackageStatus.REATTEMPT_DELIVERY:
      case PackageStatus.COLLECTED:
        return Color(0xffffd556);
      case PackageStatus.DELIVERED:
      case PackageStatus.RECEIVED_BY_LOGISTIC_CENTER:
        return Color(0xffcccccc);
      case PackageStatus.NOT_DELIVERABLE:
      default:
        return Color(0xffff6473);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getStatusChipColor(this.status),
        borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
      ),
      padding: EdgeInsets.all(6),
      child: Text(
        EnumToString.convertToString(this.status),
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
