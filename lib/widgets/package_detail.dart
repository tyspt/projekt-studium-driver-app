import 'package:dart_casing/dart_casing.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/services/package_service.dart';
import 'package:projekt_studium_driver_app/widgets/feedback_dialog.dart';
import 'package:projekt_studium_driver_app/widgets/package_list.dart';

class PackageDetailPopupDialog extends StatefulWidget {
  final Package _package;
  final Function _scanQRFn;

  PackageDetailPopupDialog(this._package, this._scanQRFn);

  @override
  _PackageDetailPopupDialogState createState() =>
      _PackageDetailPopupDialogState();
}

class _PackageDetailPopupDialogState extends State<PackageDetailPopupDialog> {
  List<Widget> actions(BuildContext context) {
    final List<Widget> allowedActions = [];
    if (widget._package.type == PackageType.INBOUND) {
      switch (widget._package.status) {
        case PackageStatus.CREATED:
          allowedActions.add(PackageDetailActionButton(
              "Start Handover Process\n(Scan QR)", widget._scanQRFn));
          break;
        case PackageStatus.IN_TRANSPORT:
          allowedActions.add(PackageDetailActionButton("Deliver Package"));
          allowedActions.add(PackageDetailActionButton("Not Deliverable"));
          break;
      }
    } else {
      switch (widget._package.status) {
        case PackageStatus.CREATED:
          allowedActions.add(PackageDetailActionButton(
              'Collect Package', () => updatePackageStatus(context)));
          break;
      }
    }
    return allowedActions;
  }

  Future<void> updatePackageStatus(BuildContext context) async {
    showLoading(context);
    try {
      await PackageService.updatePackageStatus(
          widget._package.id.toString(), PackageStatus.COLLECTED);
      Navigator.pop(context);
      setState(() {
        widget._package.status = PackageStatus.COLLECTED;
      });
      showCollectPackageResultDialog(
          context, true, "Success", "Package has been successfully collected.");
    } on Exception catch (err) {
      Navigator.pop(context);
      showCollectPackageResultDialog(
          context, false, "Collect package failed", "Error: " + err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Package #" + widget._package.id.toString()),
      children: [
        Divider(),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: [
              DetailRow(
                  'Type:',
                  Text(Casing.titleCase(
                      EnumToString.convertToString(widget._package.type)))),
              DetailRow(
                  'Tracking Number:', Text(widget._package.barcode ?? 'N/A')),
              DetailRow(
                  'Order Number:', Text(widget._package.orderNumber ?? 'N/A')),
              DetailRow('Recipient Name:',
                  Text(widget._package.recipient.name ?? 'N/A')),
              DetailRow(
                  'Email:', Text(widget._package.recipient.email ?? 'N/A')),
              DetailRow('Telephone:',
                  Text(widget._package.recipient.telephone ?? 'N/A')),
              DetailRow('Building:',
                  Text(widget._package.recipient.building.shortName ?? 'N/A')),
              DetailRow('Address:',
                  Text(widget._package.recipient.fullAddress ?? 'N/A')),
              DetailRow(
                  'Representative:',
                  Text(
                      widget._package.recipient.representative?.name ?? 'N/A')),
              DetailRow('Sender:', Text(widget._package.sender.name ?? 'N/A')),
              DetailRow('Time Created:',
                  Text(widget._package.createdTimestamp ?? 'N/A')),
              DetailRow('Last Updated:',
                  Text(widget._package.lastUpdatedTimestamp ?? 'N/A')),
              DetailRow('Status:', PackageStatusChip(widget._package.status)),
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
  final String _header;
  final Widget _content;

  DetailRow(this._header, this._content);

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
              child: Text(this._header,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 3,
            child: Container(
                alignment: Alignment.centerLeft, child: this._content),
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
