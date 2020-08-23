import 'package:commerce_models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'address.dart';
import 'item.dart';
import 'review.dart';
import 'voucher.dart';

class OrderModel {
  final OrderStatus status;
  final OrderType type;
  final String uid;
  final String merchantUid;

  /// a brief note from the user to merchant
  final String note;

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

  /// whether or not merchant has received payment; shall be set to yes if paid online
  /// merchant could manually set to true after receiving payment through other means
  final bool isPaid;

  OrderModel({
    @required this.uid,
    @required this.merchantUid,
    @required this.note,
    @required this.orderNumber,
    @required this.itemList,
    @required this.status,
    @required this.type,
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
    @required this.isPaid,
  });

  static OrderModel fromMap(Map<String, dynamic> map) {
    OrderStatus status = OrderStatus.parse(map['status']);
    OrderType type = OrderType.parse(map['type']);
    final List<ItemModel> _itemList = List.from(map['itemList'])
        .map((itemMap) => ItemModel.fromMap(Map<String, dynamic>.from(itemMap)))
        .toList();
    final List<VoucherModel> _voucherList = List.from(map['voucherList'] ?? [])
        .map((voucherMap) =>
            VoucherModel.fromMap(Map<String, dynamic>.from(voucherMap)))
        .toList();
    // uid is not assigned before the order is finalised and submitted

    final _review = map['review'] == null
        ? null
        : ReviewModel.fromMap(Map<String, dynamic>.from(map['review']));

    final _createTime = map['createTime'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['createTime']);

    final _deliveryTime = map['deliveryTime'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['deliveryTime']);

    final _address = map['address'] == null
        ? null
        : AddressModel.fromMap(Map<String, dynamic>.from(map['address']));

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
      merchantUid: map['merchantUid'],
      note: map['note'],
      orderNumber: map['orderNumber'],
      status: status,
      type: type,
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
      isPaid: map['isPaid'] ?? false,
    );
  }

  /// create order from basket and user info. this will be used in the order confirmaiton page
  static OrderModel fromBasket(UserModel user, double deliveryFee) {
    return OrderModel(
      uid: null,
      merchantUid: user.basket.merchantUid,
      note: '',
      orderNumber: null,
      createTime: null,
      deliveryTime: null,
      review: null,
      deliveryFee: deliveryFee,
      name: user.name,
      address: user.address,
      email: user.email,
      phone: user.phone,
      totalItems: user.basket.quantity,
      itemList: user.basket.itemList,
      itemsTotalPrice: user.basket.totalPrice,
      orderTotalPrice: user.basket.totalPrice + deliveryFee,
      status: OrderStatus.pending,
      type: null,
      voucherList: [],
      voucherAmount: 0,
      isPaid: false,
    );
  }

  /// this is not tested. send this to the cloud function to process the order
  Map<String, dynamic> submitOrderMap() {
    return {
      'name': this.name,
      'address': this.address.toMap(),
      'note': this.note,
      'email': this.email,
      'phone': this.phone,
      'itemList': itemList.map((e) => e.toMap()).toList(),
      'voucherList': voucherList.map((e) => e.toMap()).toList(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'merchantUid': this.merchantUid,
      'note': this.note,
      'orderNumber': this.orderNumber,
      'status': this.status?.string,
      'type': this.type?.string,
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'address': this.address?.toMap(),
      'itemList': this.itemList.map((item) => item.toMap()).toList(),
      'voucherList':
          this.voucherList.map((voucher) => voucher.toMap()).toList(),
      'deliveryFee': this.deliveryFee,
      'createTime': this.createTime?.millisecondsSinceEpoch,
      'deliveryTime': this.deliveryTime?.millisecondsSinceEpoch,
      'isPaid': this.isPaid ?? false,
    };
  }

  /// must check if the voucher could be added before calling this
  OrderModel addVoucher(VoucherModel addedVoucher) {
    final _voucherList =
        voucherList.any((voucher) => voucher.uid == addedVoucher.uid)
            ? [...voucherList]
            : [...voucherList, addedVoucher];
    final voucherMapList =
        _voucherList.map((voucher) => voucher.toMap()).toList();
    return OrderModel.fromMap({
      ...toMap(),
      'voucherList': voucherMapList,
    });
  }

  OrderModel removeVoucher(VoucherModel removedVoucher) {
    final _voucherList = voucherList
        .where((voucher) => voucher.uid != removedVoucher.uid)
        .toList();
    final voucherMapList =
        _voucherList.map((voucher) => voucher.toMap()).toList();
    return OrderModel.fromMap({
      ...toMap(),
      'voucherList': voucherMapList,
    });
  }

  String toString() {
    final createTimeString = this.createTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.createTime);
    final deliveryTimeString = this.deliveryTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.deliveryTime);
    return 'OrderModel(uid: $uid, merchantUid: $merchantUid, note: $note, orderNumber: $orderNumber, status: ${status?.string}, type: ${type?.string}, name: $name, email: $email, phone: $phone, address: $address, itemList: $itemList, voucherList: $voucherList, deliveryFee: $deliveryFee, createTime: $createTimeString, deliveryTime: $deliveryTimeString, isPaid: ${isPaid ?? false})';
  }

  @override
  bool operator ==(dynamic o) {
    return o is OrderModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}

class OrderType {
  final String _type;
  const OrderType._(this._type);

  static const delivery = OrderType._('delivery');
  static const pickup = OrderType._('pickup');

  static const values = [delivery, pickup];

  static OrderType parse(String value) {
    switch (value) {
      case 'delivery':
        return OrderType.delivery;
        break;
      case 'pickup':
        return OrderType.pickup;
        break;
      default:
        print('got error, invalid order type $value');
        return null;
    }
  }

  get string => _type;
  @override
  bool operator ==(dynamic o) {
    return o is OrderType && o._type == this._type;
  }

  @override
  int get hashCode => this._type.hashCode;
}

class OrderStatus {
  final String _status;
  const OrderStatus._(this._status);

  static const pending = OrderStatus._('pending');
  static const processing = OrderStatus._('processing');
  static const delivering = OrderStatus._('delivering');
  static const ready = OrderStatus._('ready');
  static const completed = OrderStatus._('completed');
  static const reviewed = OrderStatus._('reviewed');
  static const cancelled = OrderStatus._('cancelled');

  static const values = [
    pending,
    processing,
    delivering,
    ready,
    completed,
    reviewed,
    cancelled
  ];

  static OrderStatus parse(String value) {
    switch (value) {
      case 'pending':
        return OrderStatus.pending;
        break;
      case 'processing':
        return OrderStatus.processing;
        break;
      case 'delivering':
        return OrderStatus.delivering;
        break;
      case 'ready':
        return OrderStatus.ready;
        break;
      case 'completed':
        return OrderStatus.completed;
        break;
      case 'reviewed':
        return OrderStatus.reviewed;
        break;
      case 'cancelled':
        return OrderStatus.cancelled;
        break;
      default:
        print('got error, invalid order status $value');
        return null;
    }
  }

  get string => _status;
  @override
  bool operator ==(dynamic o) {
    return o is OrderStatus && o._status == this._status;
  }

  @override
  int get hashCode => this._status.hashCode;
}
