import 'package:commerce_models/address.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data.dart';

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
}
