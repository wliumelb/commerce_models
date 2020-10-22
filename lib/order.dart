import 'package:commerce_models/merchant.dart';
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

  /// the connected account id of the merchant
  final String stripeAccountId;

  /// a brief note from the user to merchant
  final String note;

  /// order number displayed to user and merchant
  final int orderNumber;
  final List<ItemModel> itemList;
  final int totalItems;
  final List<VoucherModel> voucherList;
  final String name;
  final String storeName;
  final String email;
  final String phone;
  final String storePhone;
  final AddressModel address;
  final AddressModel storeAddress;
  final num itemsTotalPrice;
  final num voucherAmount;
  final num deliveryFee;
  // orderTotalPrice = itemsTotalPrice - voucherAmount + deliveryFee
  final num orderTotalPrice;
  final DateTime createTime;
  final DateTime deliveryTime;
  final ReviewModel review;

  final PaymentMethod paymentMethod;
  // stripe payment id
  final String paymentId;

  /// whether or not merchant has received payment; shall be set to yes if paid online
  /// merchant could manually set to true after receiving payment through other means
  final PaymentStatus paymentStatus;

  OrderModel({
    @required this.uid,
    @required this.merchantUid,
    @required this.stripeAccountId,
    @required this.note,
    @required this.orderNumber,
    @required this.itemList,
    @required this.status,
    @required this.type,
    @required this.voucherList,
    @required this.name,
    @required this.storeName,
    @required this.address,
    @required this.storeAddress,
    @required this.email,
    @required this.phone,
    @required this.storePhone,
    @required this.totalItems,
    @required this.itemsTotalPrice,
    @required this.voucherAmount,
    @required this.deliveryFee,
    @required this.orderTotalPrice,
    @required this.createTime,
    @required this.deliveryTime,
    @required this.review,
    @required this.paymentMethod,
    @required this.paymentId,
    @required this.paymentStatus,
  });

  static OrderModel fromMap(Map<String, dynamic> map) {
    OrderStatus status = OrderStatus.parse(map['status']);
    OrderType type = OrderType.parse(map['type']);
    PaymentMethod paymentMethod = PaymentMethod.parse(map['paymentMethod']);
    PaymentStatus  paymentStatus = PaymentStatus.parse(map['paymentStatus']);
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
    final _storeAddress = map['storeAddress'] == null
        ? null
        : AddressModel.fromMap(Map<String, dynamic>.from(map['storeAddress']));

    return OrderModel(
      uid: map['uid'],
      merchantUid: map['merchantUid'],
      stripeAccountId: map['stripeAccountId'],
      note: map['note'],
      orderNumber: map['orderNumber'],
      status: status,
      type: type,
      name: map['name'],
      storeName: map['storeName'],
      email: map['email'],
      phone: map['phone'],
      storePhone: map['storePhone'],
      address: _address,
      storeAddress: _storeAddress,
      itemList: _itemList,
      voucherList: _voucherList,
      review: _review,
      createTime: _createTime,
      deliveryTime: _deliveryTime,
      totalItems: map['totalItems'],
      itemsTotalPrice: map['itemsTotalPrice'],
      deliveryFee: map['deliveryFee'],
      voucherAmount: map['voucherAmount'],
      orderTotalPrice: map['orderTotalPrice'],
      paymentMethod: paymentMethod,
      paymentId: map['paymentId'],
      paymentStatus: paymentStatus,
    );
  }

  /// create order from basket and user info. this will be used in the order confirmaiton page
  static OrderModel create({
    @required UserModel user,
    @required MerchantModel merchant,
    @required OrderType orderType,
    @required PaymentMethod paymentMethod,
    @required String orderUid,
  }) {
    final deliveryFee = orderType == OrderType.delivery
        ? merchant.deliveryFeeStructure.getDeliveryFee(user.basket.totalPrice)
        : 0;
    return OrderModel(
      uid: orderUid,
      merchantUid: user.basket.merchantUid,
      stripeAccountId: merchant.stripeAccountId,
      note: '',
      orderNumber: null,
      createTime: null,
      deliveryTime: null,
      review: null,
      deliveryFee: deliveryFee,
      name: user.name,
      storeName: merchant.name,
      address: user.address,
      storeAddress: merchant.address,
      email: user.email,
      phone: user.phone,
      storePhone: merchant.phone,
      totalItems: user.basket.quantity,
      itemList: user.basket.itemList,
      itemsTotalPrice: user.basket.totalPrice,
      orderTotalPrice: user.basket.totalPrice + deliveryFee,
      status: OrderStatus.pending,
      type: orderType,
      voucherList: [],
      voucherAmount: 0,
      paymentStatus: paymentMethod == PaymentMethod.online ? PaymentStatus.processing : PaymentStatus.pending,
      paymentMethod: paymentMethod,
      paymentId: null,
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
      'stripeAccountId': this.stripeAccountId,
      'note': this.note,
      'orderNumber': this.orderNumber,
      'status': this.status?.string,
      'type': this.type?.string,
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'address': this.address?.toMap(),
      'storeName': this.storeName,
      'storePhone': this.storePhone,
      'storeAddress': this.storeAddress?.toMap(),
      'itemList': this.itemList.map((item) => item.toMap()).toList(),
      'voucherList':
          this.voucherList.map((voucher) => voucher.toMap()).toList(),
      'deliveryFee': this.deliveryFee,
      'createTime': this.createTime?.millisecondsSinceEpoch,
      'deliveryTime': this.deliveryTime?.millisecondsSinceEpoch,
      'paymentMethod': this.paymentMethod.string,
      'paymentId': this.paymentId,
      'paymentStatus': this.paymentStatus.string,
      'totalItems': this.totalItems,
      'voucherAmount': this.voucherAmount,
      'itemsTotalPrice': this.itemsTotalPrice,
      'orderTotalPrice': this.orderTotalPrice,
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
      'voucherAmount': voucherAmount + addedVoucher.value,
      'orderTotalPrice': orderTotalPrice - addedVoucher.value,
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
      'voucherAmount': voucherAmount - removedVoucher.value,
      'orderTotalPrice': orderTotalPrice + removedVoucher.value
    });
  }

  String toString() {
    final createTimeString = this.createTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.createTime);
    final deliveryTimeString = this.deliveryTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(this.deliveryTime);
    return 'OrderModel(uid: $uid, merchantUid: $merchantUid, stripeAccountId: $stripeAccountId, note: $note, orderNumber: $orderNumber, status: ${status.string}, type: ${type.string}, name: $name, email: $email, phone: $phone, address: $address, storeName: $storeName, storePhone: $storePhone, storeAddress: $storeAddress, itemList: $itemList, voucherList: $voucherList, deliveryFee: $deliveryFee, createTime: $createTimeString, deliveryTime: $deliveryTimeString, paymentMethod: ${paymentMethod.string}, paymentId: $paymentId, paymentStatus: ${paymentStatus.string})';
  }

  @override
  bool operator ==(dynamic o) {
    return o is OrderModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}

class OrderType {
  final String string;
  const OrderType._(this.string);

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

  @override
  String toString() {
    return 'OrderType.$string';
  }
}

class PaymentMethod {
  final String _val;
  const PaymentMethod._(this._val);

  static const online = PaymentMethod._('Online');
  static const transfer = PaymentMethod._('Transfer');
  static const onDelivery = PaymentMethod._('On Delivery');
  static const inStore = PaymentMethod._('In Store');

  static const values = [online, transfer, onDelivery, inStore];

  static PaymentMethod parse(String value) {
    switch (value.toLowerCase()) {
      case 'online':
        return PaymentMethod.online;
        break;
      case 'transfer':
        return PaymentMethod.transfer;
        break;
      case 'on delivery':
        return PaymentMethod.onDelivery;
        break;
      case 'in store':
        return PaymentMethod.inStore;
        break;
      default:
        print('got error, invalid payment type $value');
        return null;
    }
  }

  String get string => _val;

  @override
  String toString() {
    return 'PaymentMethod.$_val';
  }
}

class OrderStatus {
  final String string;
  const OrderStatus._(this.string);

  static const pending = OrderStatus._('pending');
  static const processing = OrderStatus._('processing');
  static const delivering = OrderStatus._('delivering');
  static const ready = OrderStatus._('ready');
  static const completed = OrderStatus._('completed');
  static const reviewed = OrderStatus._('reviewed');
  static const canceled = OrderStatus._('canceled');

  static const values = [
    pending,
    processing,
    delivering,
    ready,
    completed,
    reviewed,
    canceled
  ];

  static const active = [pending, processing, delivering, ready];

  static const finished = [completed, reviewed, canceled];

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
      case 'canceled':
        return OrderStatus.canceled;
        break;
      default:
        print('got error, invalid order status $value');
        return null;
    }
  }

  @override
  String toString() {
    return 'OrderStatus.$string';
  }
}

class PaymentStatus {
  final String string;
  const PaymentStatus._(this.string);

  static const pending = PaymentStatus._('pending');
  static const processing = PaymentStatus._('processing');
  static const succeeded = PaymentStatus._('succeeded');
  static const canceled = PaymentStatus._('canceled');

  static const values = [
    pending,
    processing,
    succeeded,
    canceled
  ];

  static PaymentStatus parse(String value) {
    switch (value) {
      case 'pending':
        return PaymentStatus.pending;
        break;
      case 'processing':
        return PaymentStatus.processing;
        break;
      case 'succeeded':
        return PaymentStatus.succeeded;
        break;
      case 'canceled':
        return PaymentStatus.canceled;
        break;
      default:
        print('got error, invalid payment status $value');
        return null;
    }
  }

  @override
  String toString() {
    return 'PaymentStatus.$string';
  }
}
