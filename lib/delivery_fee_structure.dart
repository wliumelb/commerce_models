import 'package:flutter/foundation.dart';

class DeliveryFeeStructure {
  final List<_Tier> _tierList;
  DeliveryFeeStructure(List<_Tier> tierList) : _tierList = tierList;

  static DeliveryFeeStructure fromMapList(List<Map<String, num>> mapList) {
    print('map list is $mapList');
    final tierList = mapList
        .map(
          (map) => _Tier(
            threshold: map['threshold'],
            fee: map['fee'],
          ),
        )
        .toList()
          ..sort(
            (tier1, tier2) => (tier1.threshold - tier2.threshold).toInt(),
          );
    print('tier list is $tierList');
    return DeliveryFeeStructure(tierList);
  }

  List<_Tier> get tiers => [..._tierList];

  num getDeliveryFee(num orderAmount) {
    final length = _tierList.length;
    for (int i = length - 1; i >= 0; i--) {
      final tier = _tierList[i];
      if (orderAmount >= tier.threshold) {
        return tier.fee;
      }
    }
    return _tierList.first.fee;
  }

  List<Map<String, num>> toMapList() {
    return _tierList
        .map(
          (tier) => {'threshold': tier.threshold, 'fee': tier.fee},
        )
        .toList();
  }

  List<Map<String, num>> addTierReturnMap({
    @required num threshold,
    @required num fee,
  }) {
    if (_tierList.any((tier) =>
        tier.threshold == threshold ||
        tier.threshold > threshold && tier.fee >= fee ||
        tier.threshold < threshold && tier.fee <= fee)) {
      print('added tier does not comply with rule');
      return toMapList();
    }
    return [
      ...toMapList(),
      {
        'threshold': threshold,
        'fee': fee,
      }
    ]..sort((map1, map2) => (map1['threshold'] - map2['threshold']).toInt());
  }

  List<Map<String, num>> removeTierReturnMap({
    @required num threshold,
  }) {
    return tiers
        .where((tier) => tier.threshold != threshold)
        .map((tier) => {
              'threshold': tier.threshold,
              'fee': tier.fee,
            })
        .toList();
  }

  String toString() {
    return 'DeliveryFeeStructure($_tierList)';
  }

  @override
  bool operator ==(dynamic o) {
    return o is DeliveryFeeStructure && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}

class _Tier {
  num threshold;
  num fee;
  _Tier({
    @required this.threshold,
    @required this.fee,
  });

  String toString() {
    return '(threshold: $threshold, fee: $fee)';
  }
}
