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

  /// the domain name of store
  final String domainName;

  /// the url of the icon photo of the merchant
  /// this will be used as the icon of the web app and mobile phone app
  final String icon;

  /// order types allowed for this merchant e.g. delivery, pickup
  final List<OrderType> orderTypeList;

  /// require payment before order can be processed
  final bool requirePayment;

  final String stripeAccountId;
  final AddressModel address;
  final List<String> photoUrlList;
  final List<InfoSectionModel> infoList;
  final List<String> productCategoryList;
  final DateTime createTime;
  final DeliveryFeeStructure deliveryFeeStructure;

  MerchantModel({
    @required this.uid,
    @required this.name,
    @required this.description,
    @required this.phone,
    @required this.email,
    @required this.domainName,
    @required this.icon,
    @required this.orderTypeList,
    @required this.requirePayment,
    @required this.stripeAccountId,
    @required this.address,
    @required this.photoUrlList,
    @required this.infoList,
    @required this.productCategoryList,
    @required this.createTime,
    @required this.deliveryFeeStructure,
  });

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
      List<Map>.from(
        map['deliveryFeeStructure'] ?? [],
      ).map((map) => Map<String, num>.from(map)).toList(),
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
      domainName: map['domainName'],
      icon: map['icon'],
      requirePayment: map['requirePayment'],
      stripeAccountId: map['stripeAccountId'],
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
      'domainName': domainName,
      'icon': icon,
      'stripeAccountId': stripeAccountId,
      'orderTypeList': orderTypeList.map((type) => type.string).toList(),
      'requirePayment': requirePayment,
      'address': address?.toMap(),
      'photoUrlList': photoUrlList,
      'infoList': infoList.map((info) => info.toMap()).toList(),
      'productCategoryList': productCategoryList,
      'createTime': createTime.millisecondsSinceEpoch,
      'deliveryFeeStructure': deliveryFeeStructure.toMapList(),
    };
  }

  String toString() =>
      'MerchantModel(uid: $uid, name: $name, description: $description, phone: $phone, email: $email, domainName: $domainName, icon: $icon, stripeAccountId: $stripeAccountId, orderTypeList: $orderTypeList, requirePayment: $requirePayment, address: $address, photoUrlList: $photoUrlList, infoList: $infoList, productCategoryList: $productCategoryList, createTime: ${DateFormat('yyyy-MM-dd HH:mm').format(createTime)}, deliveryFeeStructure: $deliveryFeeStructure)';

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
