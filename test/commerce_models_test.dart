import 'package:commerce_models/address.dart';
import 'package:commerce_models/bank_card.dart';
import 'package:commerce_models/basket.dart';
import 'package:commerce_models/delivery_fee_structure.dart';
import 'package:commerce_models/info_section.dart';
import 'package:commerce_models/item.dart';
import 'package:commerce_models/merchant.dart';
import 'package:commerce_models/notification.dart';
import 'package:commerce_models/order.dart';
import 'package:commerce_models/product.dart';
import 'package:commerce_models/review.dart';
import 'package:commerce_models/user.dart';
import 'package:commerce_models/voucher.dart';
import 'package:flutter_test/flutter_test.dart';

import 'delivery_fee_structure.dart';
import 'test_data_address.dart';
import 'test_data_bank_card.dart';
import 'test_data_basket.dart';
import 'test_data_info_section.dart';
import 'test_data_item.dart';
import 'test_data_merchant.dart';
import 'test_data_notification.dart';
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

      final addedItem = ItemModel.fromMap(
          Map<String, dynamic>.from(basketTestData[i]['addedItemInput']));

      final basket3 =
          BasketModel.fromMapList(basket.addOneItemReturnMapList(addedItem));

      if (addedItem.merchantUid == basket.merchantUid) {
        if (basket.getItem(addedItem.uid) == null) {
          expect(basket3.getItem(addedItem.uid), addedItem);
          final basketAddedMore = BasketModel.fromMapList(
              basket3.addOneItemReturnMapList(addedItem));
          expect(basketAddedMore.getItem(addedItem.uid).quantity, 2);
          final basketDeletedItem = BasketModel.fromMapList(
              basketAddedMore.deleteItemReturnMapList(addedItem));
          expect(basketDeletedItem, basket);
        } else {
          expect(
            basket3.getItem(addedItem.uid).quantity,
            basket.getItem(addedItem.uid).quantity + 1,
          );
        }
        expect(basket3.quantity, basket.quantity + 1);
        expect(basket3.totalPrice, basket.totalPrice + addedItem.price);

        List<Map<String, dynamic>> thenMinusOneItemBasketMapList =
            basket3.removeOneItemReturnMapList(addedItem);

        final basket4 = BasketModel.fromMapList(thenMinusOneItemBasketMapList);
        expect(basket, basket4);
      } else {
        expect(basket3.getItem(addedItem.uid), addedItem);
        expect(basket3.itemList.length, 1);
      }

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

      if (user.address != null) {
        final user8 =
            UserModel.fromMap(user.changeAddressReturnMap(user.address));
        expect(user8, user);
      }

      print('test add and remove item');
      final newItem = ItemModel(
        category: 'fresh',
        merchantUid: 'merchant1',
        name: 'New Fruit',
        description: 'This is a new item',
        photoUrl: 'photoUrl111',
        price: 100,
        quantity: 1,
        uid: 'someUid',
      );

      if (user.basket.itemList.length > 0) {
        final existingItem = user.basket.itemList.first;
        final user9 =
            UserModel.fromMap(user.addItemToBasketReturnMap(existingItem));
        expect(user9.basket.itemList.first.quantity,
            user.basket.itemList.first.quantity + 1);

        final user10 =
            UserModel.fromMap(user9.addItemToBasketReturnMap(newItem));
        expect(user10.basket.itemList.last, newItem);
        expect(user10.basket.quantity, user.basket.quantity + 2);
        expect(user10.basket.totalPrice,
            user.basket.totalPrice + existingItem.price + newItem.price);

        final user11 = UserModel.fromMap(
          UserModel.fromMap(
            user10.removeItemFromBasketReturnMap(existingItem),
          ).removeItemFromBasketReturnMap(newItem),
        );

        expect(user11, user);
      } else {
        final user12 =
            UserModel.fromMap(user.addItemToBasketReturnMap(newItem));
        expect(user12.basket.itemList.last, newItem);
        expect(user12.basket.quantity, user.basket.quantity + 1);
        expect(
            user12.basket.totalPrice, user.basket.totalPrice + newItem.price);

        final user13 = UserModel.fromMap(
          user12.removeItemFromBasketReturnMap(newItem),
        );

        expect(user13, user);
      }

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

  test('order type and status', () {
    print('test OrderType');
    final expectedTypes = [OrderType.delivery, OrderType.pickup];
    final types = OrderType.values;
    types.forEach((type) {
      expect(expectedTypes.contains(type), true);
      expect(type, OrderType.parse(type.string));
    });
    print('done test OrderType');
    print('test OrderStatus');
    final expectedStatuses = [
      OrderStatus.pending,
      OrderStatus.processing,
      OrderStatus.ready,
      OrderStatus.delivering,
      OrderStatus.completed,
      OrderStatus.reviewed,
      OrderStatus.cancelled,
    ];
    final statuses = OrderStatus.values;
    statuses.forEach((type) {
      expect(expectedStatuses.contains(type), true);
      expect(type, OrderStatus.parse(type.string));
    });
    print('done test OrderStatus');
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
      final user = UserModel.fromMap({
        ...Map.from(userTestData[0]['input']),
        'basket': basketTestData[0]['input'],
      });
      final merchant = MerchantModel.fromMap(merchantTestData[0]['input']);
      final voucher = VoucherModel.fromMap(voucherTestData[0]['input']);
      final order3 = OrderModel.fromBasket(user, merchant, OrderType.delivery);

      expect(order3.itemsTotalPrice, user.basket.totalPrice);
      expect(
          order3.orderTotalPrice, order3.itemsTotalPrice + order3.deliveryFee);
      expect(order3.address, user.address);
      expect(order3.storeAddress, merchant.address);
      expect(order3.phone, user.phone);

      final order4 = OrderModel.fromBasket(user, merchant, OrderType.pickup);
      expect(order4.deliveryFee, 0);

      final order5 = order3.addVoucher(voucher);
      expect(order5.voucherAmount, voucher.value);
      expect(order5.orderTotalPrice, order3.orderTotalPrice - voucher.value);

      final order6 = order5.removeVoucher(voucher);
      expect(order6, order3);

      print('done order section test case $i\n');
    }
  });

  test('notification', () {
    final n = notificationTestData.length;
    for (int i = 0; i < n; i++) {
      print('test notification section test case $i');
      final input = Map<String, dynamic>.from(notificationTestData[i]['input']);
      final String stringValue = notificationTestData[i]['value'];
      final notification = NotificationModel.fromMap(input);
      final map = notification.toMap();
      final notification2 = NotificationModel.fromMap(map);
      expect(notification, notification2);
      expect(notification2.toString(), stringValue);

      if (!notification.isViewed) {
        print('test set as viewed');
        final notification3 =
            NotificationModel.fromMap(notification.setAsViewedReturnMap());
        expect(notification3.isViewed, true);
        expect(
          notification3.viewedTime.difference(DateTime.now()) <
              Duration(seconds: 1),
          true,
        );
        expect(notification3.sendTime, notification.sendTime);
        expect(notification.body, notification3.body);
        expect(notification.uid, notification3.uid);
        expect(notification.targetUid, notification3.targetUid);
        expect(notification.photoUrl, notification3.photoUrl);
        expect(notification.title, notification3.title);
        expect(notification.type, notification3.type);
      }
      print('done notification section test case $i\n');
    }
  });

  test('merchant', () {
    final n = merchantTestData.length;
    for (int i = 0; i < n; i++) {
      print('test merchant test case $i');
      final input = Map<String, dynamic>.from(merchantTestData[i]['input']);
      final String stringValue = merchantTestData[i]['value'];
      final merchant = MerchantModel.fromMap(input);
      final map = merchant.toMap();
      final merchant2 = MerchantModel.fromMap(map);
      expect(merchant, merchant2);
      expect(merchant2.toString(), stringValue);

      print('test change email, name and phone');
      final newName = 'New Name';
      final newEmail = 'email@changed.com';
      final newPhone = '12345';
      final merchant3 =
          MerchantModel.fromMap(merchant.changeNameReturnMap(newName));
      expect(merchant3.name, newName);
      final merchant4 =
          MerchantModel.fromMap(merchant3.changeEmailReturnMap(newEmail));
      expect(merchant4.email, newEmail);
      final merchant5 =
          MerchantModel.fromMap(merchant4.changePhoneReturnMap(newPhone));
      expect(merchant5.phone, newPhone);
      // change back to original. this looks ridiculous but it's fine.
      final merchant6 = MerchantModel.fromMap(
        MerchantModel.fromMap(
          MerchantModel.fromMap(
            merchant5.changeEmailReturnMap(merchant.email),
          ).changeNameReturnMap(merchant.name),
        ).changePhoneReturnMap(merchant.phone),
      );
      expect(merchant6, merchant);

      print('test change address');
      final newAddress = AddressModel(
        position: null,
        postcode: '2000',
        state: 'NSW',
        streetAddress: '123 Some Road',
        suburb: 'Sydney',
        unitNumber: '',
      );
      final merchant7 =
          MerchantModel.fromMap(merchant.changeAddressReturnMap(newAddress));
      expect(merchant7.address, newAddress);

      if (merchant.address != null) {
        final merchant8 = MerchantModel.fromMap(
            merchant.changeAddressReturnMap(merchant.address));
        expect(merchant8, merchant);
      }

      print('test change categories');
      final merchant9 = MerchantModel.fromMap(
          merchant.addCategoryReturnMap('added new category'));
      expect(merchant9.productCategoryList.last, 'added new category');
      final merchant10 = MerchantModel.fromMap(
          merchant9.removeCategoryReturnMap('added new category'));
      // should have not change anything if input category is not in the list
      final merchant11 = MerchantModel.fromMap(
          merchant10.removeCategoryReturnMap('added new category'));
      expect(merchant, merchant10);
      expect(merchant, merchant11);

      print('done merchant test case $i\n');
    }
  });

  test('delivery fee structure', () {
    final n = deliveryFeeStructureTestData.length;
    for (int i = 0; i < n; i++) {
      print('test deliveryFeeStructure section test case $i');
      final data = deliveryFeeStructureTestData[i];

      final input = List<Map<String, num>>.from(data['input']);
      final String stringValue = data['value'];
      final deliveryFeeStructure = DeliveryFeeStructure.fromMapList(input);
      final map = deliveryFeeStructure.toMapList();
      final deliveryFeeStructure2 = DeliveryFeeStructure.fromMapList(map);
      expect(deliveryFeeStructure, deliveryFeeStructure2);
      expect(deliveryFeeStructure2.toString(), stringValue);

      print('now test get values');
      final List<List<num>> tests = data['tests'];
      tests.forEach((test) {
        expect(deliveryFeeStructure.getDeliveryFee(test[0]), test[1]);
      });
      print('test adding tier');
      final addedTier = data['added'] as Map<String, num>;
      final deliveryFeeStructure3 = DeliveryFeeStructure.fromMapList(
        deliveryFeeStructure.addTierReturnMap(
          threshold: addedTier['threshold'],
          fee: addedTier['fee'],
        ),
      );

      final List<List<num>> newTests = data['new_tests'];
      newTests.forEach((test) {
        expect(deliveryFeeStructure3.getDeliveryFee(test[0]), test[1]);
      });

      print('test removing tier');
      final deliveryFeeStructure4 = DeliveryFeeStructure.fromMapList(
        deliveryFeeStructure3.removeTierReturnMap(
          threshold: addedTier['threshold'],
        ),
      );
      expect(deliveryFeeStructure, deliveryFeeStructure4);

      print('done basket section test case $i\n');
    }
  });

  test('create_user', () {
    final now = DateTime.now();
    final user = UserModel(
      address: null,
      basket: BasketModel.emptyBasket(),
      email: null,
      phone: '0129292',
      name: 'Google Name',
      uid: '12345',
      isAnonymous: true,
      createTime: now,
      lastActiveTime: now,
    );
    final user2 =
        UserModel.fromMap(user.changeEmailReturnMap('newEmail@gne.com'));
    expect(user2.email, 'newEmail@gne.com');
    final user3 = UserModel.fromMap(user.changeEmailReturnMap('null'));
    expect(user, user3);
  });
}
