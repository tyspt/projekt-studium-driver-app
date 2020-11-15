import 'package:dart_casing/dart_casing.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/widgets/package_detail.dart';

class PackageListItem extends StatelessWidget {
  final Package package;
  final Function scanQRFn;

  PackageListItem(this.package, this.scanQRFn);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Theme.of(context).primaryColor.withAlpha(30),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) =>
                    PackageDetailPopupDialog(this.package, scanQRFn));
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
      case PackageStatus.RECEIVED_BY_LC:
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
