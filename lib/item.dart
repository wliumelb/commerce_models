import 'package:commerce_models/product.dart';
import 'package:flutter/foundation.dart';

/// ItemModel is used in the basket or order display
class ItemModel {
  final String uid;
  final String name;
  final String category;
  final String merchantUid;

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
    @required this.merchantUid,
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
      merchantUid: product.merchantUid,
      name: product.name,
      category: product.category,
      description: product.description,
      photoUrl: product.photoUrlList.first,
      price: product.price,
      // set default quantity to be one because fromProduct will only be called when user add a product to the basket
      quantity: 1,
    );
  }

  static ItemModel fromMap(Map<String, dynamic> map) {
    return ItemModel(
      uid: map['uid'],
      merchantUid: map['merchantUid'],
      category: map['category'],
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
      'merchantUid': merchantUid,
      'category': category,
      'name': name,
      'description': description,
      'photoUrl': photoUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> addOneReturnMap() {
    return {
      ...toMap(),
      'quantity': quantity + 1,
    };
  }

  Map<String, dynamic> minusOneReturnMap() {
    if (quantity > 1) {
      return {
        ...toMap(),
        'quantity': quantity - 1,
      };
    }
    return null;
  }

  String toString() {
    String categoryString = category;
    return 'uid: $uid, merchantUid: $merchantUid, name: $name, category: $categoryString, description: $description, photoUrl: $photoUrl, price: $price, quantity: $quantity';
  }

  @override
  bool operator ==(dynamic o) {
    return o is ItemModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
