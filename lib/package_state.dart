import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projekt_studium_driver_app/models/package.dart';

/// This is a state model class that follows provider pattern for internal state management,
/// which follows this guide: https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
class PackageModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Package> _packages = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Package> get packages => UnmodifiableListView(_packages);

  UnmodifiableListView<Package> get outboundPackages => UnmodifiableListView(
      _packages.where((package) => package.type == PackageType.OUTBOUND));

  UnmodifiableListView<Package> get inboundPackages => UnmodifiableListView(
      _packages.where((package) => package.type == PackageType.INBOUND));

  void reloadAll(List<Package> packages) {
    _packages.clear();
    _packages.addAll(packages);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void updateOne(Package package) {
    final int index = _packages.indexOf(package);
    if (index != -1) {
      _packages[index] = package;
      notifyListeners();
    }
  }
}
