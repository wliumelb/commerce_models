import 'package:commerce_models/item.dart';
import 'package:flutter/foundation.dart';
import 'basket.dart';

import 'address.dart';

class UserModel {
  final String uid;
  final String name;
  final bool isAnonymous;
  final String phone;
  final String email;
  final AddressModel address;
  final BasketModel basket;

  /// the token used by server to send firebase message; also distinguish new logins from other devices
  final String fcmToken;

  UserModel({
    @required this.uid,
    @required this.name,
    @required this.isAnonymous,
    @required this.phone,
    @required this.email,
    @required this.address,
    @required this.basket,
    @required this.fcmToken,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    final addressMap = Map<String, dynamic>.from(map['address']);
    final address = AddressModel.fromMap(addressMap);

    final itemMapList = List<Map<String, dynamic>>.from(map['basket']);
    final basket = BasketModel.fromMapList(itemMapList);

    return UserModel(
      uid: map['uid'],
      name: map['name'],
      isAnonymous: map['isAnonymous'],
      phone: map['phone'],
      email: map['email'],
      address: address,
      basket: basket,
      fcmToken: map['fcmToken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'isAnonymous': isAnonymous,
      'phone': phone,
      'email': email,
      'address': address.toMap(),
      'basket': basket.toMapList(),
      'fcmToken': fcmToken,
    };
  }

  String toString() =>
      'uid: $uid, name: $name, isAnonymous: $isAnonymous, phone: $phone, email: $email, address: ${address.toString()}, basket: ${basket.toString()}, fcmToken: $fcmToken';

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

  Map<String, dynamic> addItemToBasketReturnMap(ItemModel addedItem) => {
        ...toMap(),
        'basket': basket.addOneItemReturnMapList(addedItem),
      };

  Map<String, dynamic> minusItemToBasketReturnMap(ItemModel removedItem) => {
        ...toMap(),
        'basket': basket.minusOneItemReturnMapList(removedItem),
      };

  @override
  bool operator ==(dynamic o) {
    return o is UserModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
