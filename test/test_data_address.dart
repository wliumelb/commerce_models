import 'package:commerce_models/address.dart';

final addressTestData = [
  {
    'input': {
      'unitNumber': '',
      'postcode': '3284',
      'suburb': 'Port Fairy',
      'state': 'VIC',
      'streetAddress': '28 Villiers St',
    },
    'value': '28 Villiers St, Port Fairy, VIC 3284'
  },
  {
    'input': {
      'unitNumber': '604',
      'postcode': '3053',
      'suburb': 'Carlton',
      'state': 'VIC',
      'streetAddress': '640 Swanston St',
    },
    'value': '604 / 640 Swanston St, Carlton, VIC 3053'
  },
];

final List<AddressModel> addressList = addressTestData.map((map) {
  final inputMap = Map<String, dynamic>.from(map['input']);
  return AddressModel.fromMap(inputMap);
}).toList();
