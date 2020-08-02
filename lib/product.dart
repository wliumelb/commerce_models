import 'dart:ui';

import 'package:commerce_models/info_section.dart';
import 'package:flutter/foundation.dart';

class ProductModel {
  final String uid;
  final String name;
  final Category category;

  /// the brief description for the product to be displayed next to the photos
  final String description;

  /// the list of products' photos
  final List<String> photoUrlList;

  /// list of infosection for detailed display of product
  final List<InfoSectionModel> infoList;

  /// unit price
  final num price;

  /// stock quantity
  final int quantity;
  ProductModel({
    @required this.uid,
    @required this.category,
    @required this.description,
    @required this.name,
    @required this.photoUrlList,
    @required this.infoList,
    @required this.price,
    @required this.quantity,
  });

  get photoUrl => null;

  static ProductModel fromMap(Map<String, dynamic> map, {int quantity}) {
    Category category;
    switch (map['category']) {
      case 'fresh':
        category = Category.fresh;
        break;
      case 'meat':
        category = Category.meat;
        break;
      default:
    }

    final infoList = List.from(map['infoList'])
        .map((map) => InfoSectionModel.fromMap(Map.from(map)))
        .toList();

    return ProductModel(
      uid: map['uid'],
      category: category,
      name: map['name'],
      description: map['description'],
      photoUrlList: map['photoUrlList'],
      infoList: infoList,
      price: map['price'],
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'category': category.toString().split('.')[1],
      'name': name,
      'description': description,
      'photoUrlList': photoUrlList,
      'infoList': infoList.map((info) => info.toMap()).toList(),
      'price': price,
      'quantity': quantity,
    };
  }

  String toString() {
    String categoryString = category.toString().split('.')[1];
    List infoStringList = infoList.map((info) => info.toString()).toList();
    return 'uid: $uid, name: $name, category: $categoryString, description: $description, photoUrlList: $photoUrlList, infoList: $infoStringList, price: $price, quantity: $quantity';
  }

  @override
  bool operator ==(dynamic o) {
    return o is ProductModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => hashValues(this.toString(), '');
}

enum Category {
  fresh,
  meat,
  // more to come
}
