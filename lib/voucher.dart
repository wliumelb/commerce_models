import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class VoucherModel {
  final String uid;

  /// vouchers are bound to user uids
  final String userUid;

  /// uid of user that send the voucher. used to track for reward to the sharer
  final String sharerUid;

  /// number to be deducted from order. $6 $8 $10
  final num value;

  /// minimum spend to enable voucher. $20
  final num threshold;

  /// isValid == unused
  final bool isValid;
  final DateTime expireDate;

  VoucherModel({
    @required this.uid,
    @required this.userUid,
    @required this.sharerUid,
    @required this.value,
    @required this.threshold,
    @required this.expireDate,
    @required this.isValid,
  });

  static VoucherModel fromMap(Map<String, dynamic> map) {
    final expireDate = map['expireDate'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['expireDate']);

    return VoucherModel(
      uid: map['uid'],
      userUid: map['userUid'],
      sharerUid: map['sharerUid'],
      value: map['value'],
      threshold: map['threshold'],
      expireDate: expireDate,
      isValid: map['isValid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'userUid': this.userUid,
      'sharerUid': this.sharerUid,
      'value': this.value,
      'threshold': this.threshold,
      'expireDate': expireDate?.millisecondsSinceEpoch,
      'isValid': isValid,
    };
  }

  String toString() =>
      'VoucherModel(uid: $uid, userUid: $userUid, sharerUid: $sharerUid, value: $value, threshold: $threshold, expireDate: ${DateFormat('yyyy-MM-dd HH:mm').format(expireDate)}, isValid: $isValid)';

  @override
  bool operator ==(dynamic o) {
    return o is VoucherModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
