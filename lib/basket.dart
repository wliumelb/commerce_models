import 'package:commerce_models/item.dart';
import 'package:flutter/foundation.dart';

class BasketModel {
  // key is item uid
  final List<ItemModel> _itemList;

  final String merchantUid;

  /// total number of items in the basket
  final int quantity;

  /// sum of items' prices, excluding postage and voucher
  final num totalPrice;

  BasketModel({
    @required List<ItemModel> itemList,
    @required this.merchantUid,
    @required this.quantity,
    @required this.totalPrice,
  }) : _itemList = itemList;

  // this will prevent _itemList from getting mutated
  List<ItemModel> get itemList => [..._itemList];

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
      merchantUid: itemList.length > 0 ? itemList?.first?.merchantUid : null,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }

  static BasketModel emptyBasket() => BasketModel(
        itemList: [],
        merchantUid: null,
        quantity: 0,
        totalPrice: 0,
      );

  List<Map<String, dynamic>> toMapList() =>
      _itemList.map((item) => item.toMap()).toList();

  ItemModel getItem(String itemUid) => _itemList.firstWhere(
        (item) => item.uid == itemUid,
        orElse: () => null,
      );

  static List<Map<String, dynamic>> addFirstItemReturnMapList(ItemModel item) {
    return BasketModel(
      itemList: [item],
      merchantUid: item.merchantUid,
      quantity: 1,
      totalPrice: item.price,
    ).toMapList();
  }

  /// need to check merchantUid of the new item and existing items
  List<Map<String, dynamic>> addOneItemReturnMapList(ItemModel addedItem) {
    // check if addedItem is from the same merchantUid as the existing items
    // if not, clean the basket and replace it with the new item
    if (this.merchantUid != addedItem.merchantUid) {
      return [addedItem.toMap()];
    } else {
      final List<Map<String, dynamic>> result = [];
      bool hasItem = false;
      this._itemList.forEach((item) {
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
  }

  List<Map<String, dynamic>> removeOneItemReturnMapList(ItemModel removedItem) {
    return _itemList.map((item) {
      if (item.uid == removedItem.uid) {
        // return null if item.quantity == 1, so need to remove possible null
        return item.minusOneReturnMap();
      }
      return item.toMap();
    }).toList()
      ..remove(null);
  }

  List<Map<String, dynamic>> deleteItemReturnMapList(ItemModel removedItem) {
    return _itemList
        .where((item) => item.uid != removedItem.uid)
        .map((item) => item.toMap())
        .toList();
  }

  String toString() {
    return 'BasketModel(itemList: ${_itemList.map((item) => item.toString()).toList()}, quantity: $quantity, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(dynamic o) {
    return o is BasketModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
