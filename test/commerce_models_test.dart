import 'package:commerce_models/address.dart';
import 'package:commerce_models/bank_card.dart';
import 'package:commerce_models/basket.dart';
import 'package:commerce_models/info_section.dart';
import 'package:commerce_models/item.dart';
import 'package:commerce_models/order.dart';
import 'package:commerce_models/product.dart';
import 'package:commerce_models/product_category.dart';
import 'package:commerce_models/review.dart';
import 'package:commerce_models/user.dart';
import 'package:commerce_models/voucher.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data_address.dart';
import 'test_data_bank_card.dart';
import 'test_data_basket.dart';
import 'test_data_info_section.dart';
import 'test_data_item.dart';
import 'test_data_order.dart';
import 'test_data_product.dart';
import 'test_data_review.dart';
import 'test_data_user.dart';
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

  test('user', () {
    final n = userTestData.length;
    for (int i = 0; i < n; i++) {
      print('test user section test case $i');
      final input = Map<String, dynamic>.from(userTestData[i]['input']);
      final String stringValue = userTestData[i]['value'];
      final user = UserModel.fromMap(input);
      final map = user.toMap();
      final user2 = UserModel.fromMap(map);
      expect(user, user2);
      expect(user2.toString(), stringValue);

      print('test change email, name and phone');
      final newName = 'New Name';
      final newEmail = 'email@changed.com';
      final newPhone = '12345';
      final user3 = UserModel.fromMap(user.changeNameReturnMap(newName));
      expect(user3.name, newName);
      final user4 = UserModel.fromMap(user3.changeEmailReturnMap(newEmail));
      expect(user4.email, newEmail);
      final user5 = UserModel.fromMap(user4.changePhoneReturnMap(newPhone));
      expect(user5.phone, newPhone);
      // change back to original. this looks ridiculous but it's fine.
      final user6 = UserModel.fromMap(
        UserModel.fromMap(
          UserModel.fromMap(
            user5.changeEmailReturnMap(user.email),
          ).changeNameReturnMap(user.name),
        ).changePhoneReturnMap(user.phone),
      );
      expect(user6, user);

      print('test change address');
      final newAddress = AddressModel(
        position: null,
        postcode: '2000',
        state: 'NSW',
        streetAddress: '123 Some Road',
        suburb: 'Sydney',
        unitNumber: '',
      );
      final user7 = UserModel.fromMap(user.changeAddressReturnMap(newAddress));
      expect(user7.address, newAddress);

      final user8 =
          UserModel.fromMap(user.changeAddressReturnMap(user.address));
      expect(user8, user);

      print('test add and remove item');
      final existingItem = user.basket.itemList.first;
      final newItem = ItemModel(
        category: ProductCategory.fresh,
        name: 'New Fruit',
        description: 'This is a new item',
        photoUrl: 'photoUrl111',
        price: 100,
        quantity: 1,
        uid: 'someUid',
      );
      final user9 =
          UserModel.fromMap(user.addItemToBasketReturnMap(existingItem));
      expect(user9.basket.itemList.first.quantity,
          user.basket.itemList.first.quantity + 1);

      final user10 = UserModel.fromMap(user9.addItemToBasketReturnMap(newItem));
      expect(user10.basket.itemList.last, newItem);
      expect(user10.basket.quantity, user.basket.quantity + 2);
      expect(user10.basket.totalPrice,
          user.basket.totalPrice + existingItem.price + newItem.price);

      final user11 = UserModel.fromMap(
        UserModel.fromMap(
          user10.minusItemToBasketReturnMap(existingItem),
        ).minusItemToBasketReturnMap(newItem),
      );

      expect(user11, user);

      print('done user section test case $i\n');
    }
  });

  test('review', () {
    final n = reviewTestData.length;
    for (int i = 0; i < n; i++) {
      print('test review section test case $i');
      final input = Map<String, dynamic>.from(reviewTestData[i]['input']);
      final String stringValue = reviewTestData[i]['value'];
      final review = ReviewModel.fromMap(input);
      final map = review.toMap();
      final review2 = ReviewModel.fromMap(map);
      expect(review, review2);
      expect(review2.toString(), stringValue);
      print('done review section test case $i\n');
    }
  });

  test('order', () {
    final n = orderTestData.length;
    for (int i = 0; i < n; i++) {
      print('test order section test case $i');
      final input = Map<String, dynamic>.from(orderTestData[i]['input']);
      final String stringValue = orderTestData[i]['value'];
      final order = OrderModel.fromMap(input);
      final map = order.toMap();
      final order2 = OrderModel.fromMap(map);
      expect(order, order2);
      expect(order2.toString(), stringValue);

      print('test from basket');
      final user = UserModel.fromMap(userTestData[0]['input']);
      final basket = BasketModel.fromMapList(basketTestData[0]['input']);
      final voucher = VoucherModel.fromMap(voucherTestData[0]['input']);
      final order3 = OrderModel.fromBasket(user, basket);

      expect(order3.itemsTotalPrice, basket.totalPrice);
      expect(
          order3.orderTotalPrice, order3.itemsTotalPrice + order3.deliveryFee);
      expect(order3.address, user.address);
      expect(order3.phone, user.phone);

      final order4 = OrderModel.fromMap(order3.addVoucherReturnMap(voucher));
      expect(order4.voucherAmount, voucher.value);
      expect(order4.orderTotalPrice, order3.orderTotalPrice - voucher.value);

      final order5 = OrderModel.fromMap(order4.removeVoucherReturnMap(voucher));
      expect(order5, order3);

      print('done order section test case $i\n');
    }
  });
}
