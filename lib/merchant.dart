import 'package:commerce_models/delivery_fee_structure.dart';
import 'package:commerce_models/info_section.dart';
import 'package:commerce_models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'address.dart';

class MerchantModel {
  final String uid;
  final String name;
  final String description;
  final String phone;
  final String email;

  /// if the merchant allow user to make online payment (through Stripe SDK)
  /// false means merchant only accept other payment methods such as bank transfer, cash on delivery
  final bool onlinePaymentAllowed;

  /// if the merchant require payemnt to be made when order is submitted
  /// if false user could submit order and then make payment
  final bool onlinePaymentRequired;

  /// order types allowed for this merchant
  final List<OrderType> orderTypeList;
  final AddressModel address;
  final List<String> photoUrlList;
  final List<InfoSectionModel> infoList;
  final List<String> productCategoryList;
  final DateTime createTime;
  final DeliveryFeeStructure _deliveryFeeStructure;

  MerchantModel({
    @required this.uid,
    @required this.name,
    @required this.description,
    @required this.phone,
    @required this.email,
    @required this.onlinePaymentAllowed,
    @required this.onlinePaymentRequired,
    @required this.orderTypeList,
    @required this.address,
    @required this.photoUrlList,
    @required this.infoList,
    @required this.productCategoryList,
    @required this.createTime,
    @required DeliveryFeeStructure deliveryFeeStructure,
  }) : _deliveryFeeStructure = deliveryFeeStructure;

  static MerchantModel fromMap(Map<String, dynamic> map) {
    final address = map['address'] == null
        ? null
        : AddressModel.fromMap(Map<String, dynamic>.from(map['address']));

    final photoUrlList = List<String>.from(map['photoUrlList'] ?? []);
    final productCategoryList =
        List<String>.from(map['productCategoryList'] ?? []);

    final infoList = List<Map>.from(map['infoList'] ?? [])
        .map((e) => InfoSectionModel.fromMap(e))
        .toList();
    final orderTypeList = List<String>.from(map['orderTypeList'] ?? [])
        .map((str) => OrderType.parse(str))
        .toList();
    final deliveryFeeStructure = DeliveryFeeStructure.fromMapList(
      List<Map<String, num>>.from(
        map['deliveryFeeStructure'] ?? [],
      ),
    );

    if (orderTypeList.length == 0) {
      print('warning, order type list should contain at least one type');
    }

    final int timeStamp = map['createTime'] ?? 1597884720000;
    final createTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    return MerchantModel(
      uid: map['uid'],
      name: map['name'],
      description: map['description'],
      phone: map['phone'],
      email: map['email'],
      onlinePaymentAllowed: map['onlinePaymentAllowed'] ?? false,
      onlinePaymentRequired: map['onlinePaymentRequired'] ?? false,
      address: address,
      photoUrlList: photoUrlList,
      infoList: infoList,
      productCategoryList: productCategoryList,
      createTime: createTime,
      orderTypeList: orderTypeList,
      deliveryFeeStructure: deliveryFeeStructure,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'phone': phone,
      'email': email,
      'onlinePaymentAllowed': onlinePaymentAllowed,
      'onlinePaymentRequired': onlinePaymentRequired,
      'orderTypeList': orderTypeList.map((type) => type.string).toList(),
      'address': address?.toMap(),
      'photoUrlList': photoUrlList,
      'infoList': infoList.map((info) => info.toMap()).toList(),
      'productCategoryList': productCategoryList,
      'createTime': createTime.millisecondsSinceEpoch,
      'deliveryFeeStructure': _deliveryFeeStructure.toMapList(),
    };
  }

  String toString() =>
      'MerchantModel(uid: $uid, name: $name, description: $description, phone: $phone, email: $email, onlinePaymentAllowed: $onlinePaymentAllowed, onlinePaymentRequired: $onlinePaymentRequired, orderTypeList: $orderTypeList, address: $address, photoUrlList: $photoUrlList, infoList: $infoList, productCategoryList: $productCategoryList, createTime: ${DateFormat('yyyy-MM-dd HH:mm').format(createTime)}, deliveryFeeStructure: $_deliveryFeeStructure)';

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

  Map<String, dynamic> addCategoryReturnMap(String newCategory) => {
        ...toMap(),
        'productCategoryList': productCategoryList == null
            ? [newCategory]
            : [...productCategoryList, newCategory],
      };

  Map<String, dynamic> removeCategoryReturnMap(String newCategory) => {
        ...toMap(),
        'productCategoryList': productCategoryList == null
            ? []
            : productCategoryList.where((category) => category != newCategory),
      };

  @override
  bool operator ==(dynamic o) {
    return o is MerchantModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
