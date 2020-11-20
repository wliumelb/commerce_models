import 'package:flutter/foundation.dart';

class AddressModel {
  final String unitNumber;
  final String streetAddress;
  final String suburb;
  final String state;
  final String postcode;
  AddressModel({
    @required this.unitNumber,
    @required this.streetAddress,
    @required this.suburb,
    @required this.state,
    @required this.postcode,
  });
  static AddressModel fromMap(Map<String, dynamic> map) {
    return AddressModel(
      unitNumber: (map['unitNumber'] as String)?.trim(),
      streetAddress: (map['streetAddress'] as String)?.trim(),
      suburb: (map['suburb'] as String)?.trim(),
      state: (map['state'] as String)?.trim(),
      postcode: (map['postcode'] as String)?.trim(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'unitNumber': this.unitNumber?.trim(),
      'streetAddress': this.streetAddress?.trim(),
      'suburb': this.suburb?.trim(),
      'state': this.state?.trim(),
      'postcode': this.postcode?.trim(),
    };
  }

  @override
  String toString() {
    if (unitNumber != null && unitNumber != '') {
      return '$unitNumber / $streetAddress, $suburb, $state $postcode';
    }

    return '$streetAddress, $suburb, $state $postcode';
  }

  @override
  bool operator ==(dynamic o) {
    return o is AddressModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
