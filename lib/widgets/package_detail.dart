import 'package:dart_casing/dart_casing.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/package_state.dart';
import 'package:projekt_studium_driver_app/services/package_service.dart';
import 'package:projekt_studium_driver_app/widgets/feedback_dialog.dart';
import 'package:projekt_studium_driver_app/widgets/package_list.dart';
import 'package:provider/provider.dart';

void showPackageDetailDialog(
    BuildContext context, Package package, Function scanQR) {
  Provider.of<PackageModel>(context, listen: false).selectAsActive(package);
  showDialog(
      context: context,
      builder: (_) => Consumer<PackageModel>(
            builder: (context, model, child) {
              return PackageDetailPopupDialog(model.activePackage);
            },
          ));
}

class PackageDetailPopupDialog extends StatelessWidget {
  final Package _package;

  PackageDetailPopupDialog(this._package);

  /// List of buttons that can be performed on an inbound package
  List<Widget> _inboundActions(BuildContext context) {
    final List<Widget> allowedActions = [];
    switch (_package.status) {
      case PackageStatus.IN_TRANSPORT:
      case PackageStatus.REATTEMPT_DELIVERY:
        allowedActions.add(PackageDetailActionButton("Mark as Delivered",
            () => this._updatePackageStatus(context, PackageStatus.DELIVERED)));
        allowedActions.add(PackageDetailActionButton(
            "Reschedule Delivery",
            () => this._updatePackageStatus(
                context, PackageStatus.REATTEMPT_DELIVERY)));
        allowedActions.add(PackageDetailActionButton(
            "Not Deliverable",
            () => this
                ._updatePackageStatus(context, PackageStatus.NOT_DELIVERABLE)));
        break;
      default:
        break;
    }
    return allowedActions;
  }

  /// List of buttons that can be performed on an outbound package
  List<Widget> _outboundActions(BuildContext context) {
    final List<Widget> allowedActions = [];
    switch (_package.status) {
      case PackageStatus.CREATED:
        allowedActions.add(PackageDetailActionButton(
            'Collect Package',
            () => this
                ._updatePackageStatus(context, PackageStatus.IN_TRANSPORT)));
        break;
      default:
        break;
    }
    return allowedActions;
  }

  Future<void> _updatePackageStatus(
      BuildContext context, PackageStatus targetStatus) async {
    showLoading(context);
    try {
      final updatedPackage = await PackageService.updatePackageStatus(
          _package.id.toString(), targetStatus);
      Navigator.pop(context);
      Provider.of<PackageModel>(context, listen: false)
          .updateActivePackageData(updatedPackage);
      showCollectPackageResultDialog(
          context,
          true,
          "Success",
          "Package has been successfully marked as " +
              EnumToString.convertToString(targetStatus) +
              ".");
    } on Exception catch (err) {
      Navigator.pop(context);
      showCollectPackageResultDialog(context, false,
          "Failed to update package status", "Error: " + err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Package #" + _package.id.toString()),
      children: [
        Divider(),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: [
              DetailRow(
                  'Type:',
                  Text(Casing.titleCase(
                      EnumToString.convertToString(_package.type)))),
              DetailRow('Tracking Number:', Text(_package.barcode ?? 'N/A')),
              DetailRow('Order Number:', Text(_package.orderNumber ?? 'N/A')),
              DetailRow(
                  'Recipient Name:', Text(_package.recipient.name ?? 'N/A')),
              DetailRow('Email:', Text(_package.recipient.email ?? 'N/A')),
              DetailRow(
                  'Telephone:', Text(_package.recipient.telephone ?? 'N/A')),
              DetailRow('Building:',
                  Text(_package.recipient.building.shortName ?? 'N/A')),
              DetailRow(
                  'Address:', Text(_package.recipient.fullAddress ?? 'N/A')),
              DetailRow('Representative:',
                  Text(_package.recipient.representative?.name ?? 'N/A')),
              DetailRow('Sender:', Text(_package.sender.name ?? 'N/A')),
              DetailRow(
                  'Time Created:', Text(_package.createdTimestamp ?? 'N/A')),
              DetailRow('Last Updated:',
                  Text(_package.lastUpdatedTimestamp ?? 'N/A')),
              DetailRow('Status:', PackageStatusChip(_package.status)),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: _package.type == PackageType.INBOUND
                    ? _inboundActions(context)
                    : _outboundActions(context),
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
