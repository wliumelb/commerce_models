import 'package:commerce_models/address.dart';
import 'package:commerce_models/bank_card.dart';
import 'package:commerce_models/basket.dart';
import 'package:commerce_models/info_section.dart';
import 'package:commerce_models/item.dart';
import 'package:commerce_models/product.dart';
import 'package:commerce_models/voucher.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data_address.dart';
import 'test_data_bank_card.dart';
import 'test_data_basket.dart';
import 'test_data_info_section.dart';
import 'test_data_item.dart';
import 'test_data_product.dart';
import 'test_data_voucher.dart';

void main() {
  test('address', () {
    final n = addressTestData.length;
    for (int i = 0; i < n; i++) {
      print('test address test case $i');
      final input = Map<String, dynamic>.from(addressTestData[i]['input']);
      final String stringValue = addressTestData[i]['value'];
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
      final String stringValue = infoSectionTestData[i]['value'];
      final info = InfoSectionModel.fromMap(input);
      final map = info.toMap();
      final info2 = InfoSectionModel.fromMap(map);
      expect(info, info2);
      expect(info2.toString(), stringValue);
      print('done info section test case $i\n');
    }
  });

  test('product', () {
    final n = productTestData.length;
    for (int i = 0; i < n; i++) {
      print('test product section test case $i');
      final input = Map<String, dynamic>.from(productTestData[i]['input']);
      final String stringValue = productTestData[i]['value'];
      final product = ProductModel.fromMap(input);
      final map = product.toMap();
      final product2 = ProductModel.fromMap(map);
      expect(product, product2);
      expect(product2.toString(), stringValue);
      print('done product section test case $i\n');
    }
  });

  test('item', () {
    final n = itemTestData.length;
    for (int i = 0; i < n; i++) {
      print('test item section test case $i');
      final input = Map<String, dynamic>.from(itemTestData[i]['input']);
      final String stringValue = itemTestData[i]['value'];
      final item = ItemModel.fromMap(input);
      final map = item.toMap();
      final item2 = ItemModel.fromMap(map);
      expect(item, item2);
      expect(item2.toString(), stringValue);

      final addOneMap = item.addOneReturnMap();
      final item3 = ItemModel.fromMap(addOneMap);
      expect(item.quantity, item3.quantity - 1);

      final thenMinusOneMap = item3.minusOneReturnMap();
      final item4 = ItemModel.fromMap(thenMinusOneMap);
      expect(item, item4);

      final productInput = itemTestData[i]['productInput'];
      if (productInput != null) {
        print('now test fromProduct');
        final product = ProductModel.fromMap(productInput);
        final item3 = ItemModel.fromProduct(product);
        expect(item, item3);
      }

      print('done item section test case $i\n');
    }
  });

  test('voucher', () {
    final n = voucherTestData.length;
    for (int i = 0; i < n; i++) {
      print('test voucher section test case $i');
      final input = Map<String, dynamic>.from(voucherTestData[i]['input']);
      final String stringValue = voucherTestData[i]['value'];
      final voucher = VoucherModel.fromMap(input);
      final map = voucher.toMap();
      final voucher2 = VoucherModel.fromMap(map);
      expect(voucher, voucher2);
      expect(voucher2.toString(), stringValue);
      print('done voucher section test case $i\n');
    }
  });

  test('basket', () {
    final n = basketTestData.length;
    for (int i = 0; i < n; i++) {
      print('test basket section test case $i');
      final input = List<Map<String, dynamic>>.from(basketTestData[i]['input']);
      final String stringValue = basketTestData[i]['value'];
      final basket = BasketModel.fromMapList(input);
      final map = basket.toMapList();
      final basket2 = BasketModel.fromMapList(map);
      expect(basket, basket2);
      expect(basket2.toString(), stringValue);

      print('test adding item');

      final addedItemMap =
          Map<String, dynamic>.from(basketTestData[i]['addedItemInput']);
      final addedItem = ItemModel.fromMap(addedItemMap);

      List<Map<String, dynamic>> addedOneItemBasketMapList =
          basket2.addOneItemReturnMapList(addedItem);

      final basket3 = BasketModel.fromMapList(addedOneItemBasketMapList);

      expect(basket3.quantity, basket.quantity + 1);
      expect(basket3.totalPrice, basket.totalPrice + addedItem.price);

      List<Map<String, dynamic>> thenMinusOneItemBasketMapList =
          basket3.minusOneItemReturnMapList(addedItem);

      final basket4 = BasketModel.fromMapList(thenMinusOneItemBasketMapList);
      expect(basket, basket4);

      print('done basket section test case $i\n');
    }
  });

  test('bankCard', () {
    final n = bankCardTestData.length;
    for (int i = 0; i < n; i++) {
      print('test bankCard section test case $i');
      final input = Map<String, dynamic>.from(bankCardTestData[i]['input']);
      final String stringValue = bankCardTestData[i]['value'];
      final bankCard = BankCardModel.fromMap(input);
      final map = bankCard.toMap();
      final bankCard2 = BankCardModel.fromMap(map);
      expect(bankCard, bankCard2);
      expect(bankCard2.toString(), stringValue);

      print('test set as default');

      final setAsDefaultMap = bankCard.setAsDefaultReturnMap();
      final bankCard3 = BankCardModel.fromMap(setAsDefaultMap);

      final setAsNotDefaultMap = bankCard.setAsNotDefaultReturnMap();
      final bankCard4 = BankCardModel.fromMap(setAsNotDefaultMap);

      if (bankCard.isDefault) {
        expect(bankCard, bankCard3);
      } else {
        expect(bankCard, bankCard4);
      }

      print('done bankCard section test case $i\n');
    }
  });
}
