import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/package_data.dart';

class PackageList extends StatelessWidget {
  final packages = PackageData.data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: packages.map((package) => PackageItem(package)).toList(),
      ),
    );
  }
}

class PackageItem extends StatelessWidget {
  final package;

  PackageItem(this.package);

  @override
  Widget build(BuildContext context) {
    _getStatusChipColor(String status) {
      switch (status) {
        case 'GELIEFERT':
          return Color(0xff868e96);
        case 'IM_TRANSPORT':
          return Color(0xffffc107);
        case 'ERFASST':
        case 'SORTIERT':
          return Color(0xff28a745);
      }
    }

    return Card(
      child: InkWell(
          splashColor: Theme.of(context).primaryColor.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Text(package['recipient']['building']),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Casing.titleCase(package['recipient']['name']),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '#' + package['barcode'],
                              ),
                              Text(package['timeCreated'],
                                  textScaleFactor: 0.9,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                            ],
                          ),
                          Spacer(),
                          Chip(
                            padding:
                                const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                            backgroundColor:
                                _getStatusChipColor(package['status']),
                            label: Text(
                              Casing.titleCase(package['status']),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        package['recipient']['fullAddress'],
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
