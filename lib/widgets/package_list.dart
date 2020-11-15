import 'package:dart_casing/dart_casing.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/widgets/package_detail.dart';

class PackageList extends StatelessWidget {
  final List<Package> _packages;
  final Function _scanQRFn;

  PackageList(this._packages, this._scanQRFn);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: _packages
            .map<Widget>((package) => PackageListItem(package, _scanQRFn))
            .toList());
  }
}

class PackageListItem extends StatelessWidget {
  final Package _package;
  final Function _scanQRFn;

  PackageListItem(this._package, this._scanQRFn);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Theme.of(context).primaryColor.withAlpha(30),
          onTap: () => showPackageDetailDialog(context, _package, _scanQRFn),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // Left Avatar section
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Text(_package.recipient.building.shortName),
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
                                Casing.titleCase(_package.recipient.name),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '#' + _package.barcode,
                              ),
                              Text(_package.createdTimestamp,
                                  textScaleFactor: 0.9,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ],
                          ),
                          Spacer(),
                          PackageStatusChip(_package.status),
                        ],
                      ),
                      Text(
                        _package.recipient.fullAddress,
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
  final PackageStatus _status;

  PackageStatusChip(this._status);

  Color _getStatusChipColor(PackageStatus status) {
    switch (status) {
      case PackageStatus.CREATED:
        return Color(0xff53da72);
      case PackageStatus.IN_HANDOVER:
        return Color(0xffd2b9ff);
      case PackageStatus.IN_TRANSPORT:
      case PackageStatus.REATTEMPT_DELIVERY:
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
        color: _getStatusChipColor(this._status),
        borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
      ),
      padding: EdgeInsets.all(6),
      child: Text(
        EnumToString.convertToString(this._status),
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
