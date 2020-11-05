import 'package:projekt_studium_driver_app/models/package.dart';

class PackageData {
  static final data = [
    {
      'id': '1',
      'barcode': '1937917519711295139517',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'F31',
        'fullAddress': 'Siemensstraße 12 Geb. F31/3/2, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'GELIEFERT',
      'type': Type.INBOUND,
    },
    {
      'id': '2',
      'barcode': '1724719749171921373931',
      'recipient': {
        'name': 'MICHAEL NOEL',
        'email': 'michael.noel@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'KEVIN MATTHEWS',
        'email': 'kevin.matthews@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'BETTIE JONES',
      },
      'status': 'IM_TRANSPORT',
      'type': Type.OUTBOUND,
    },
    {
      'id': '3',
      'barcode': '1378979849812083132213',
      'recipient': {
        'name': 'EMMETT TILL',
        'email': 'emmett.till@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'MEDGAR EVERS',
        'email': 'medgar.evers@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'GEORGE JUNIUS STINNEY',
      },
      'status': 'SORTIERT',
      'type': Type.INBOUND,
    },
    {
      'id': '4',
      'barcode': '1792379102749017340917',
      'recipient': {
        'name': 'MARTIN LUTHER KING',
        'email': 'martin.luther.king@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'HENRY SMITH',
        'email': 'henry.smith@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'JOHN CRAWFORD',
      },
      'status': 'SORTIERT',
      'type': Type.INBOUND,
    },
    {
      'id': '5',
      'barcode': '1275891757197590177232',
      'recipient': {
        'name': 'MICHAEL BROWN',
        'email': 'michael.brown@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'EZELL FORD',
        'email': 'ezell.ford@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'DANTE PARKER',
      },
      'status': 'GELIEFERT',
      'type': Type.INBOUND,
    },
    {
      'id': '6',
      'barcode': '4797689068208207602863',
      'recipient': {
        'name': 'QUINTONIO LEGRIER',
        'email': 'QUINTONIO.LEGRIER@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'KEITH CHILDRESS',
        'email': 'KEITH.CHILDRESS @continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'JANET WILSON',
      },
      'status': 'IM_TRANSPORT',
      'type': Type.INBOUND,
    },
    {
      'id': '7',
      'barcode': '3795798501808372975948',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'IM_TRANSPORT',
      'type': Type.INBOUND,
    },
    {
      'id': '8',
      'barcode': '9489758268364824832172',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'GELIEFERT',
      'type': Type.INBOUND,
    },
    {
      'id': '9',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'GELIEFERT',
      'type': Type.INBOUND,
    },
    {
      'id': '10',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'SORTIERT',
      'type': Type.INBOUND,
    },
    {
      'id': '11',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'SORTIERT',
      'type': Type.INBOUND,
    },
    {
      'id': '12',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'IM_TRANSPORT',
      'type': Type.INBOUND,
    },
    {
      'id': '13',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '14',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'F12',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'C37',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '15',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'B22',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'K47',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '16',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'F12',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '17',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'A12',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'B15',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '18',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'C22',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'F15a',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '19',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'K15',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'A12',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '20',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'C31',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'K22',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '21',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'F03',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'G12',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '22',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'H55',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'K47',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '23',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'F13',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'F05',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '24',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'K19',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'A15',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '25',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'C22',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'D36',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '26',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'A15',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'B32',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '27',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'C05',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'K42',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.INBOUND,
    },
    {
      'id': '28',
      'barcode': '4621642642641264124261',
      'recipient': {
        'name': 'John Doe',
        'email': 'john.doe@continental.com',
        'telephone': '123-4567890',
        'building': 'O15',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/7, Regensburg',
      },
      'timeCreated': '2020-10-30 12:42:35',
      'representative': {
        'name': 'Anna Musterfrau',
        'email': 'anna.musterfrau@continental.com',
        'telephone': '987-6543210',
        'building': 'K12',
        'fullAddress': 'Siemensstraße 12 Geb. D42/4/8, Regensburg',
      },
      'sender': {
        'name': 'Max Mustermann',
      },
      'status': 'ERFASST',
      'type': Type.OUTBOUND,
    },
  ];
}
