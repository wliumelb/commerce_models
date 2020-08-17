import 'package:commerce_models/info_section.dart';
import 'package:flutter/foundation.dart';

/// ProductModel is used in the display page of the product
class ProductModel {
  final String uid;
  final String merchantUid;
  final String name;
  final String category;

  final bool isAvailable;

  /// the brief description for the product to be displayed next to the photos
  final String description;

  /// the list of products' photos
  final List<String> photoUrlList;

  /// list of infosection for detailed display of product
  final List<InfoSectionModel> infoList;

  /// unit price
  final num price;

  /// stock quantity
  final int stock;

  /// number of items sold in total
  final int sold;

  ProductModel({
    @required this.uid,
    @required this.merchantUid,
    @required this.category,
    @required this.isAvailable,
    @required this.description,
    @required this.name,
    @required this.photoUrlList,
    @required this.infoList,
    @required this.price,
    @required this.stock,
    @required this.sold,
  });

  static ProductModel fromMap(Map<String, dynamic> map, {int stock}) {
    final infoList = List.from(map['infoList'])
        .map((map) => InfoSectionModel.fromMap(Map.from(map)))
        .toList();
    final photoUrlList = List<String>.from(map['photoUrlList']);

    return ProductModel(
      uid: map['uid'],
      merchantUid: map['merchantUid'],
      category: map['category'],
      isAvailable: map['isAvailable'],
      name: map['name'],
      description: map['description'],
      photoUrlList: photoUrlList,
      infoList: infoList,
      price: map['price'],
      stock: map['stock'] ?? 0,
      sold: map['sold'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'merchantUid': merchantUid,
      'category': category,
      'isAvailable': isAvailable,
      'name': name,
      'description': description,
      'photoUrlList': photoUrlList,
      'infoList': infoList.map((info) => info.toMap()).toList(),
      'price': price,
      'stock': stock,
      'sold': sold,
    };
  }

  String toString() {
    String categoryString = category;
    List infoStringList = infoList.map((info) => info.toString()).toList();
    return 'uid: $uid, merchantUid: $merchantUid, name: $name, category: $categoryString, isAvailable: $isAvailable, description: $description, photoUrlList: $photoUrlList, infoList: $infoStringList, price: $price, stock: $stock, sold: $sold';
  }

  @override
  bool operator ==(dynamic o) {
    return o is ProductModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
