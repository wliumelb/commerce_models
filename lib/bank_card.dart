import 'package:flutter/foundation.dart';

class BankCardModel {
  final String uid;

  /// VISA, MasterBank, etc
  final String brand;

  /// there could be multiple cards. One card is the default card
  final bool isDefault;
  final int expirationMonth;
  final int expirationYear;
  final String lastFourDigits;

  BankCardModel({
    @required this.uid,
    @required this.brand,
    @required this.isDefault,
    @required this.expirationMonth,
    @required this.expirationYear,
    @required this.lastFourDigits,
  });
  static BankCardModel fromMap(Map<String, dynamic> map) {
    return BankCardModel(
      uid: map['uid'],
      brand: map['brand'],
      isDefault: map['isDefault'],
      expirationMonth: map['expirationMonth'],
      expirationYear: map['expirationYear'],
      lastFourDigits: map['lastFourDigits'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'brand': brand,
      'isDefault': isDefault,
      'expirationMonth': expirationMonth,
      'expirationYear': expirationYear,
      'lastFourDigits': lastFourDigits,
    };
  }

  Map<String, dynamic> setAsDefaultReturnMap() {
    return {
      'uid': uid,
      'brand': brand,
      'isDefault': true,
      'expirationMonth': expirationMonth,
      'expirationYear': expirationYear,
      'lastFourDigits': lastFourDigits,
    };
  }

  Map<String, dynamic> setAsNotDefaultReturnMap() {
    return {
      'uid': uid,
      'brand': brand,
      'isDefault': false,
      'expirationMonth': expirationMonth,
      'expirationYear': expirationYear,
      'lastFourDigits': lastFourDigits,
    };
  }

  String toString() =>
      'BankCardModel(uid: $uid, brand: $brand, isDefault: $isDefault, expirationMonth: $expirationMonth, expirationYear: $expirationYear, lastFourDigits: $lastFourDigits)';

  @override
  bool operator ==(dynamic o) {
    return o is BankCardModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
