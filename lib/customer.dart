import 'package:commerce_models/cart.dart';
import 'package:commerce_models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'address.dart';

class CustomerModel {
  final String uid;
  final CartModel cart;
  final DateTime lastVisit;

  CustomerModel({
    @required this.uid,
    @required this.cart,
    @required this.lastVisit,
  });

  static CustomerModel fromMap(Map<String, dynamic> map) {
    final cart = CartModel.fromMapList(
      List.from(map['cart'])
          .map(
            (map) => Map<String, dynamic>.from(map),
          )
          .toList(),
    );
    final int lastVisitStamp = map['lastVisit'] ?? 1597884720000;
    final lastVisit = DateTime.fromMillisecondsSinceEpoch(lastVisitStamp);

    return CustomerModel(
      uid: map['uid'],
      lastVisit: lastVisit,
      cart: cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'cart': cart.toMapList(),
      'lastVisit': lastVisit.millisecondsSinceEpoch,
    };
  }

  String toString() =>
      'CustomerModel(uid: $uid, cart: $cart, lastVisit: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(lastVisit)})';

  Map<String, dynamic> changeAddressReturnMap(AddressModel newAddress) => {
        ...toMap(),
        'address': newAddress.toMap(),
      };

  Map<String, dynamic> changeNameReturnMap(String newName) => {
        ...toMap(),
        'name': newName,
      };

  Map<String, dynamic> changePhoneReturnMap(String newPhone) => {
        ...toMap(),
        'phone': newPhone,
      };

  Map<String, dynamic> changeEmailReturnMap(String newEmail) => {
        ...toMap(),
        'email': newEmail,
      };

  Map<String, dynamic> updateLastActiveTimeReturnMap(ItemModel removedItem) => {
        ...toMap(),
        'lastActiveTime': DateTime.now(),
      };

  @override
  bool operator ==(dynamic o) {
    return o is CustomerModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
