import 'package:commerce_models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
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
  final DateTime createTime;

  UserModel({
    @required this.uid,
    @required this.name,
    @required this.isAnonymous,
    @required this.phone,
    @required this.email,
    @required this.address,
    @required this.basket,
    @required this.createTime,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    final address = map['address'] == null
        ? null
        : AddressModel.fromMap(Map<String, dynamic>.from(map['address']));

    final itemMapList = List<Map<String, dynamic>>.from(map['basket']);
    final basket = BasketModel.fromMapList(itemMapList);
    final int timeStamp = map['createTime'] ?? 1597884720000;
    final createTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    return UserModel(
      uid: map['uid'],
      name: map['name'],
      isAnonymous: map['isAnonymous'],
      phone: map['phone'],
      email: map['email'],
      address: address,
      basket: basket,
      createTime: createTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'isAnonymous': isAnonymous,
      'phone': phone,
      'email': email,
      'address': address?.toMap(),
      'basket': basket.toMapList(),
      'createTime': createTime.millisecondsSinceEpoch,
    };
  }

  String toString() =>
      'UserModel(uid: $uid, name: $name, isAnonymous: $isAnonymous, phone: $phone, email: $email, address: ${address.toString()}, basket: ${basket.toString()}, createTime: ${DateFormat('yyyy-MM-dd HH:mm').format(createTime)})';

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

  Map<String, dynamic> removeItemFromBasketReturnMap(ItemModel removedItem) => {
        ...toMap(),
        'basket': basket.removeOneItemReturnMapList(removedItem),
      };

  @override
  bool operator ==(dynamic o) {
    return o is UserModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
