import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projekt_studium_driver_app/models/package.dart';

/// A state model class that follows provider pattern for internal package state management, read this guide
/// for more details: https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
class PackageModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Package> _packages = [];
  Package _activePackage;

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Package> get packages => UnmodifiableListView(_packages);

  UnmodifiableListView<Package> get inboundPackages => UnmodifiableListView(
      _packages.where((package) => package.type == PackageType.INBOUND));

  UnmodifiableListView<Package> get outboundPackages => UnmodifiableListView(
      _packages.where((package) => package.type == PackageType.OUTBOUND));

  Package get activePackage => _activePackage;

  void reloadAll(List<Package> packages) {
    _packages.clear();
    _packages.addAll(packages);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void selectAsActive(Package package) {
    this._activePackage = package;
    notifyListeners();
  }

  void updateActivePackageData(Package package) {
    final int index = _packages.indexOf(package);
    assert(index != -1 && _activePackage.id == package.id);
    _packages[index] = package;
    _activePackage = package;
    notifyListeners();
  }
}
