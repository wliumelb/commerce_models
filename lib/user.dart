import 'package:commerce_models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'address.dart';

class UserModel {
  final String uid;
  final String stripeCustomerId;
  final String name;
  final bool isAnonymous;
  final String phone;
  final String email;
  final AddressModel address;
  final DateTime createTime;
  final DateTime lastActiveTime;

  UserModel({
    @required this.uid,
    @required this.stripeCustomerId,
    @required this.name,
    @required this.isAnonymous,
    @required this.phone,
    @required this.email,
    @required this.address,
    @required this.createTime,
    @required this.lastActiveTime,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    final address = map['address'] == null
        ? null
        : AddressModel.fromMap(Map<String, dynamic>.from(map['address']));

    final int createTimeStamp = map['createTime'] ?? 1597884720000;
    final int lastActiveTimeStamp = map['lastActiveTime'] ?? 1597884720000;
    final createTime = DateTime.fromMillisecondsSinceEpoch(createTimeStamp);
    final lastActiveTime =
        DateTime.fromMillisecondsSinceEpoch(lastActiveTimeStamp);

    return UserModel(
      uid: map['uid'],
      stripeCustomerId: map['stripeCustomerId'],
      name: map['name'],
      isAnonymous: map['isAnonymous'],
      phone: map['phone'],
      email: map['email'],
      address: address,
      createTime: createTime,
      lastActiveTime: lastActiveTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'stripeCustomerId': stripeCustomerId,
      'name': name,
      'isAnonymous': isAnonymous,
      'phone': phone,
      'email': email,
      'address': address?.toMap(),
      'createTime': createTime.millisecondsSinceEpoch,
      'lastActiveTime': lastActiveTime.millisecondsSinceEpoch,
    };
  }

  String toString() =>
      'UserModel(uid: $uid, stripeCustomerId: $stripeCustomerId, name: $name, isAnonymous: $isAnonymous, phone: $phone, email: $email, address: ${address.toString()}, createTime: ${DateFormat('yyyy-MM-dd HH:mm').format(createTime)}, lastActiveTime: ${DateFormat('yyyy-MM-dd HH:mm').format(lastActiveTime)})';

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
    return o is UserModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
