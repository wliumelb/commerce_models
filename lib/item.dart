import 'dart:ui';

import 'package:commerce_models/product.dart';
import 'package:commerce_models/product_category.dart';
import 'package:flutter/foundation.dart';

/// ItemModel is used in the basket or order display
class ItemModel {
  final String uid;
  final String name;
  final ProductCategory category;

  /// the brief description for the product to be displayed next to the photos
  final String description;

  /// this should be the first photo of the product's photoUrlList
  final String photoUrl;

  /// unit price
  final num price;

  /// number of items in the basket / order
  final int quantity;

  ItemModel({
    @required this.uid,
    @required this.category,
    @required this.description,
    @required this.name,
    @required this.photoUrl,
    @required this.price,
    @required this.quantity,
  });

  static ItemModel fromProduct(ProductModel product) {
    return ItemModel(
      uid: product.uid,
      name: product.name,
      category: product.category,
      description: product.description,
      photoUrl: product.photoUrlList.first,
      price: product.price,
      // set default quantity to be one because fromProduct will only be called when user add a product to the basket
      quantity: 1,
    );
  }

  static ItemModel fromMap(Map<String, dynamic> map, {int quantity}) {
    ProductCategory category;
    switch (map['category']) {
      case 'fresh':
        category = ProductCategory.fresh;
        break;
      case 'meat':
        category = ProductCategory.meat;
        break;
      default:
    }

    return ItemModel(
      uid: map['uid'],
      category: category,
      name: map['name'],
      photoUrl: map['photoUrl'],
      description: map['description'],
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
      'photoUrl': photoUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  String toString() {
    String categoryString = category.toString().split('.')[1];
    return 'uid: $uid, name: $name, category: $categoryString, description: $description, photoUrl: $photoUrl, price: $price, quantity: $quantity';
  }

  @override
  bool operator ==(dynamic o) {
    return o is ItemModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => hashValues(this.toString(), '');
}