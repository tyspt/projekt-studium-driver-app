import 'package:projekt_studium_driver_app/models/package.dart';

abstract class PackageData {
  List<Package> getData();

  Package getPackagebyId(String id);

  Package getPackagebyBarcode(String barcode);
}
