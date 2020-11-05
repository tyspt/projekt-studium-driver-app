import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PackageList extends StatelessWidget {
  final packages;

  PackageList(this.packages);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: packages
            .map<Widget>((package) => PackageListItem(package))
            .toList(),
      ),
    );
  }
}

class PackageListItem extends StatelessWidget {
  final package;

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
                  child: Text(package['recipient']['building']),
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
                          PackageStatusChip(package['status']),
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

class PackageDetailPopupDialog extends StatelessWidget {
  final package;

  PackageDetailPopupDialog(this.package);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Package Detail #" + package['barcode']),
      children: [
        Center(
          child: Column(
            children: [
              DetailRow('Tracking Number:', Text(package['barcode'])),
              DetailRow('Order Number:', Text('N/A')), // TODO
              DetailRow('Recipient Name:', Text(package['recipient']['name'])),
              DetailRow('Email:', Text(package['recipient']['email'])),
              DetailRow('Telephone:', Text(package['recipient']['telephone'])),
              DetailRow('Building:', Text(package['recipient']['building'])),
              DetailRow('Address:', Text(package['recipient']['fullAddress'])),
              DetailRow(
                  'Representative:', Text(package['representative']['name'])),
              DetailRow('Sender:', Text(package['sender']['name'])),
              DetailRow('Time Created:', Text(package['timeCreated'])),
              DetailRow('Status:', PackageStatusChip(package['status'])),
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
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
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
  final String packageStatus;

  PackageStatusChip(this.packageStatus);

  Color _getStatusChipColor(String status) {
    switch (status) {
      case 'GELIEFERT':
        return Color(0xff868e96);
      case 'IM_TRANSPORT':
        return Color(0xffffc107);
      case 'ERFASST':
      case 'SORTIERT':
      default:
        return Color(0xff28a745);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getStatusChipColor(this.packageStatus),
        borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
      ),
      padding: EdgeInsets.all(6),
      child: Text(
        Casing.titleCase(this.packageStatus),
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
