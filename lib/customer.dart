import 'package:commerce_models/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CustomerModel {
  final String uid;
  final String phone;
  final CartModel cart;
  final DateTime lastVisit;

  CustomerModel({
    @required this.uid,
    @required this.phone,
    @required this.cart,
    @required this.lastVisit,
  });

  static CustomerModel fromMap(Map<String, dynamic> map) {
    final cart = CartModel.fromMapList(
      List.from(map['cart'] ?? [])
          .map(
            (map) => Map<String, dynamic>.from(map),
          )
          .toList(),
    );
    final int lastVisitStamp = map['lastVisit'];
    final lastVisit = lastVisitStamp == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(lastVisitStamp);

    return CustomerModel(
      uid: map['uid'],
      phone: map['phone'],
      lastVisit: lastVisit,
      cart: cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'cart': cart.toMapList(),
      'lastVisit': lastVisit.millisecondsSinceEpoch,
    };
  }

  String toString() =>
      'CustomerModel(uid: $uid, phone: $phone, cart: $cart, lastVisit: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(lastVisit)})';

  @override
  bool operator ==(dynamic o) {
    return o is CustomerModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
