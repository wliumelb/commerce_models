import 'package:commerce_models/basket.dart';
import 'package:commerce_models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'address.dart';
import 'item.dart';
import 'review.dart';
import 'voucher.dart';

class OrderModel {
  final OrderStatus status;
  final String uid;

  /// order number displayed to user and merchant
  final int orderNumber;
  final List<ItemModel> itemList;
  final int totalItems;
  final List<VoucherModel> voucherList;
  final String name;
  final String email;
  final String phone;
  final AddressModel address;
  final num itemsTotalPrice;
  final num voucherAmount;
  final num deliveryFee;
  // orderTotalPrice = itemsTotalPrice - voucherAmount + deliveryFee
  final num orderTotalPrice;
  final DateTime createTime;
  final DateTime deliveryTime;
  final ReviewModel review;
  OrderModel({
    @required this.uid,
    @required this.orderNumber,
    @required this.itemList,
    @required this.status,
    @required this.voucherList,
    @required this.name,
    @required this.address,
    @required this.email,
    @required this.phone,
    @required this.totalItems,
    @required this.itemsTotalPrice,
    @required this.voucherAmount,
    @required this.deliveryFee,
    @required this.orderTotalPrice,
    @required this.createTime,
    @required this.deliveryTime,
    @required this.review,
  });

  static OrderModel fromMap(Map<String, dynamic> map) {
    OrderStatus status;
    switch (map['status']) {
      case 'pending':
        status = OrderStatus.pending;
        break;
      case 'processing':
        status = OrderStatus.processing;
        break;
      case 'delivering':
        status = OrderStatus.delivering;
        break;
      case 'completed':
        status = OrderStatus.completed;
        break;
      case 'reviewed':
        status = OrderStatus.reviewed;
        break;
      case 'cancelled':
        status = OrderStatus.cancelled;
        break;
      default:
        print('error, booking status');
    }

    final List<ItemModel> _itemList = List.from(map['itemList'])
        .map((itemMap) => ItemModel.fromMap(Map<String, dynamic>.from(itemMap)))
        .toList();
    final List<VoucherModel> _voucherList = List.from(map['voucherList'] ?? [])
        .map((voucherMap) =>
            VoucherModel.fromMap(Map<String, dynamic>.from(voucherMap)))
        .toList();
    // uid is not assigned before the order is finalised and submitted
    final notSubmittedYet = map['uid'] == null;

    final _review = map['review'] == null
        ? null
        : ReviewModel.fromMap(Map<String, dynamic>.from(map['review']));

    final _createTime =
        notSubmittedYet ? null : DateTime.parse(map['createTime']);

    final _deliveryTime =
        notSubmittedYet ? null : DateTime.parse(map['deliveryTime']);

    final _address =
        AddressModel.fromMap(Map<String, dynamic>.from(map['address']));

    int _totalItems = 0;
    num _itemsTotalPrice = 0;
    num _voucherAmount = 0;
    final num _deliveryFee = map['deliveryFee'];

    _itemList.forEach((item) {
      _totalItems += item.quantity;
      _itemsTotalPrice += item.quantity * item.price;
    });

    _voucherList.forEach((voucher) {
      _voucherAmount += voucher.value;
    });

    final _orderTotalPrice = _itemsTotalPrice + _deliveryFee - _voucherAmount;

    return OrderModel(
      uid: map['uid'],
      orderNumber: map['orderNumber'],
      status: status,
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: _address,
      itemList: _itemList,
      voucherList: _voucherList,
      review: _review,
      createTime: _createTime,
      deliveryTime: _deliveryTime,
      totalItems: _totalItems,
      itemsTotalPrice: _itemsTotalPrice,
      deliveryFee: _deliveryFee,
      voucherAmount: _voucherAmount,
      orderTotalPrice: _orderTotalPrice,
    );
  }

  /// create order from basket and user info. This order is not complete, should not call toMap
  static OrderModel fromBasket(UserModel user, BasketModel basket) {
    final deliveryFee = 6;
    return OrderModel(
      uid: null,
      orderNumber: null,
      createTime: null,
      deliveryTime: null,
      review: null,
      deliveryFee: deliveryFee,
      name: user.name,
      address: user.address,
      email: user.email,
      phone: user.phone,
      totalItems: basket.quantity,
      itemList: basket.itemList,
      itemsTotalPrice: basket.totalPrice,
      orderTotalPrice: basket.totalPrice + deliveryFee,
      status: OrderStatus.pending,
      voucherList: [],
      voucherAmount: 0,
    );
  }

  /// this is not tested. send this to the cloud function to process the order
  Map<String, dynamic> submitOrderMap() {
    return {
      'name': this.name,
      'address': this.address.toMap(),
      'email': this.email,
      'phone': this.phone,
      'itemList': itemList.map((e) => e.toMap()).toList(),
      'voucherList': voucherList.map((e) => e.toMap()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    final createTimeString = this.createTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.createTime);
    final deliveryTimeString = this.deliveryTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.deliveryTime);
    return {
      'uid': this.uid,
      'orderNumber': this.orderNumber,
      'status': this.status.toString().split('.')[1],
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'address': this.address.toMap(),
      'itemList': this.itemList.map((item) => item.toMap()).toList(),
      'voucherList':
          this.voucherList.map((voucher) => voucher.toMap()).toList(),
      'deliveryFee': this.deliveryFee,
      'createTime': createTimeString,
      'deliveryTime': deliveryTimeString,
    };
  }

  /// must check if the voucher could be added before calling this
  Map<String, dynamic> addVoucherReturnMap(VoucherModel addedVoucher) {
    final _voucherList =
        voucherList.any((voucher) => voucher.uid == addedVoucher.uid)
            ? [...voucherList]
            : [...voucherList, addedVoucher];
    final voucherMapList =
        _voucherList.map((voucher) => voucher.toMap()).toList();
    return {
      ...toMap(),
      'voucherList': voucherMapList,
    };
  }

  Map<String, dynamic> removeVoucherReturnMap(VoucherModel removedVoucher) {
    final _voucherList = voucherList
        .where((voucher) => voucher.uid != removedVoucher.uid)
        .toList();
    final voucherMapList =
        _voucherList.map((voucher) => voucher.toMap()).toList();
    return {
      ...toMap(),
      'voucherList': voucherMapList,
    };
  }

  String toString() {
    final String statusString = status.toString().split('.')[1];
    final createTimeString = this.createTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.createTime);
    final deliveryTimeString = this.createTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.deliveryTime);
    return 'uid: $uid, orderNumber: $orderNumber, status: $statusString, name: $name, email: $email, phone: $phone, address: $address, itemList: $itemList, voucherList: $voucherList, deliveryFee: $deliveryFee, createTime: $createTimeString, deliveryTime: $deliveryTimeString';
  }

  @override
  bool operator ==(dynamic o) {
    return o is OrderModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}

enum OrderStatus {
  pending, // order not submitted yet
  processing, // customer has made the payment
  delivering, // it's on the way to the customer
  completed, // order is delivered to the address
  reviewed, // customer has confirmed delivery and given review
  cancelled, // cancelled
}
