import 'package:dart_casing/dart_casing.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/widgets/package_card.dart';

class PackageDetailPopupDialog extends StatelessWidget {
  final Package package;
  final Function _scanQRFn;

  PackageDetailPopupDialog(this.package, this._scanQRFn);

  List<Widget> actions(BuildContext context) {
    final List<Widget> allowedActions = [];
    if (package.type == PackageType.INBOUND) {
      switch (package.status) {
        case PackageStatus.CREATED:
          allowedActions.add(PackageDetailActionButton(
              "Start Handover Process\n(Scan QR)", _scanQRFn));
          break;
        case PackageStatus.IN_TRANSPORT:
          allowedActions.add(PackageDetailActionButton("Deliver Package"));
          allowedActions.add(PackageDetailActionButton("Not Deliverable"));
          break;
      }
    } else {
      switch (package.status) {
        case PackageStatus.CREATED:
          allowedActions
              .add(PackageDetailActionButton('Collect Package', _scanQRFn));
          break;
      }
    }
    return allowedActions;
  }

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
                children: actions(context),
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

class PackageDetailActionButton extends StatelessWidget {
  final String _data;
  final VoidCallback _onPressed;

  PackageDetailActionButton(this._data, [this._onPressed]);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _data,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
