import 'package:commerce_models/info_section.dart';
import 'package:flutter/foundation.dart';

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
  final AddressModel address;
  final List<String> photoUrlList;
  final List<InfoSectionModel> infoList;
  final List<String> productCategoryList;

  MerchantModel({
    @required this.uid,
    @required this.name,
    @required this.description,
    @required this.phone,
    @required this.email,
    @required this.onlinePaymentAllowed,
    @required this.onlinePaymentRequired,
    @required this.address,
    @required this.photoUrlList,
    @required this.infoList,
    @required this.productCategoryList,
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
      'address': address?.toMap(),
      'photoUrlList': photoUrlList,
      'infoList': infoList.map((info) => info.toMap()).toList(),
      'productCategoryList': productCategoryList,
    };
  }

  String toString() =>
      'uid: $uid, name: $name, description: $description, phone: $phone, email: $email, onlinePaymentAllowed: $onlinePaymentAllowed, onlinePaymentRequired: $onlinePaymentRequired, address: ${address.toString()}, photoUrlList: $photoUrlList, infoList: $infoList, productCategoryList: $productCategoryList';

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
