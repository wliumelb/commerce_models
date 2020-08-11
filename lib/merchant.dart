import 'package:commerce_models/info_section.dart';
import 'package:flutter/foundation.dart';

import 'address.dart';

class MerchantModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final AddressModel address;
  final List<String> photoUrlList;
  final List<InfoSectionModel> info;
  final List<String> productCategoryList;

  MerchantModel({
    @required this.uid,
    @required this.name,
    @required this.phone,
    @required this.email,
    @required this.address,
    @required this.photoUrlList,
    @required this.info,
    @required this.productCategoryList,
  });

  static MerchantModel fromMap(Map<String, dynamic> map) {
    final address = map['address'] == null
        ? null
        : AddressModel.fromMap(Map<String, dynamic>.from(map['address']));

    final photoUrlList = List<String>.from(map['photoUrlList'] ?? []);
    final productCategoryList =
        List<String>.from(map['productCategoryList'] ?? []);

    final info = List<Map>.from(map['info'] ?? [])
        .map((e) => InfoSectionModel.fromMap(e))
        .toList();

    return MerchantModel(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      address: address,
      photoUrlList: photoUrlList,
      info: info,
      productCategoryList: productCategoryList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address?.toMap(),
      'photoUrlList': photoUrlList,
      'info': info.map((info) => info.toMap()).toList(),
      'productCategoryList': productCategoryList,
    };
  }

  String toString() =>
      'uid: $uid, name: $name, phone: $phone, email: $email, address: ${address.toString()}, photoUrlList: $photoUrlList, info: $info, productCategoryList: $productCategoryList';

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
