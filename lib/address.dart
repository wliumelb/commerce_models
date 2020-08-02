import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';

class AddressModel {
  final String unitNumber;
  final String streetAddress;
  final String suburb;
  final String state;
  final String postcode;
  final GeoPoint position;
  AddressModel({
    @required this.unitNumber,
    @required this.streetAddress,
    @required this.suburb,
    @required this.state,
    @required this.postcode,
    @required this.position,
  });
  static AddressModel fromMap(Map<String, dynamic> map) {
    return AddressModel(
      unitNumber: (map['unitNumber'] as String)?.trim(),
      streetAddress: (map['streetAddress'] as String)?.trim(),
      suburb: (map['suburb'] as String)?.trim(),
      state: (map['state'] as String)?.trim(),
      postcode: (map['postcode'] as String)?.trim(),
      position: map['position'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'unitNumber': this.unitNumber?.trim(),
      'streetAddress': this.streetAddress?.trim(),
      'suburb': this.suburb?.trim(),
      'state': this.state?.trim(),
      'postcode': this.postcode?.trim(),
      'position': this.position,
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
  int get hashCode => hashValues(this.toString(), '');
}
