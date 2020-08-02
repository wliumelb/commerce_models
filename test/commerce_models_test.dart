import 'package:commerce_models/address.dart';
import 'package:commerce_models/info_section.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data_address.dart';
import 'test_data_info_section.dart';

void main() {
  test('address', () {
    final n = addressTestData.length;
    for (int i = 0; i < n; i++) {
      print('test address test case $i');
      final input = Map<String, dynamic>.from(addressTestData[i]['input']);
      final stringValue = addressTestData[i]['value'];
      final address = AddressModel.fromMap(input);
      final map = address.toMap();
      final address2 = AddressModel.fromMap(map);
      expect(address, address2);
      expect(address2.toString(), stringValue);
      print('done address test case $i\n');
    }
  });

  test('infoSection', () {
    final n = infoSectionTestData.length;
    for (int i = 0; i < n; i++) {
      print('test info section test case $i');
      final input = Map<String, dynamic>.from(infoSectionTestData[i]['input']);
      final stringValue = infoSectionTestData[i]['value'];
      final info = InfoSectionModel.fromMap(input);
      final map = info.toMap();
      final info2 = InfoSectionModel.fromMap(map);
      expect(info, info2);
      expect(info2.toString(), stringValue);
      print('done info section test case $i\n');
    }
  });
}
