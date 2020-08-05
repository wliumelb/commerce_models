import 'package:commerce_models/item.dart';
import 'package:flutter/foundation.dart';

class BasketModel {
  // key is item uid
  final List<ItemModel> itemList;

  /// total number of items in the basket
  final int quantity;

  /// sum of items' prices, excluding postage and voucher
  final num totalPrice;

  BasketModel({
    @required this.itemList,
    @required this.quantity,
    @required this.totalPrice,
  });

  static BasketModel fromMapList(List<Map<String, dynamic>> mapList) {
    final itemList = mapList
        .map((map) => ItemModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();
    int quantity = 0;
    num totalPrice = 0;
    itemList.forEach((item) {
      quantity += item.quantity;
      totalPrice += item.quantity * item.price;
    });

    return BasketModel(
      itemList: itemList,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }

  static BasketModel emptyBasket() => BasketModel(
        itemList: [],
        quantity: 0,
        totalPrice: 0,
      );

  List<Map<String, dynamic>> toMapList() =>
      itemList.map((item) => item.toMap()).toList();

  static List<Map<String, dynamic>> addFirstItemReturnMapList(ItemModel item) {
    return BasketModel(
      itemList: [item],
      quantity: 1,
      totalPrice: item.price,
    ).toMapList();
  }

  List<Map<String, dynamic>> addOneItemReturnMapList(ItemModel addedItem) {
    final List<Map<String, dynamic>> result = [];
    bool hasItem = false;
    this.itemList.forEach((item) {
      if (item.uid == addedItem.uid) {
        hasItem = true;
        result.add(item.addOneReturnMap());
      } else {
        result.add(item.toMap());
      }
    });
    if (!hasItem) result.add(addedItem.toMap());
    return result;
  }

  List<Map<String, dynamic>> minusOneItemReturnMapList(ItemModel removedItem) {
    return itemList.map((item) {
      if (item.uid == removedItem.uid) {
        // return null if item.quantity == 1, so need to remove possible null
        return item.minusOneReturnMap();
      }
      return item.toMap();
    }).toList()
      ..remove(null);
  }

  String toString() {
    return 'itemList: ${itemList.map((item) => item.toString()).toList()}, quantity: $quantity, totalPrice: $totalPrice';
  }

  @override
  bool operator ==(dynamic o) {
    return o is BasketModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
