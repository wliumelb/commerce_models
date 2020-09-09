import 'package:flutter/foundation.dart';

class DeliveryFeeStructure {
  final List<FeeTier> tierList;
  DeliveryFeeStructure(this.tierList);

  static DeliveryFeeStructure fromMapList(List<Map<String, num>> mapList) {
    final tierList = mapList
        .map(
          (map) => FeeTier(
            threshold: map['threshold'],
            fee: map['fee'],
          ),
        )
        .toList()
          ..sort(
            (tier1, tier2) => (tier1.threshold - tier2.threshold).toInt(),
          );
    return DeliveryFeeStructure(tierList);
  }

  List<FeeTier> get tiers => [...tierList];

  num getDeliveryFee(num orderAmount) {
    final length = tierList.length;
    if (length == 0) {
      print('got error, delivery fee structure not available');
      return 0;
    }
    for (int i = length - 1; i >= 0; i--) {
      final tier = tierList[i];
      if (orderAmount >= tier.threshold) {
        return tier.fee;
      }
    }
    return tierList.first.fee;
  }

  List<Map<String, num>> toMapList() {
    return tierList
        .map(
          (tier) => {'threshold': tier.threshold, 'fee': tier.fee},
        )
        .toList();
  }

  List<Map<String, num>> addTierReturnMap({
    @required num threshold,
    @required num fee,
  }) {
    if (tierList.any((tier) =>
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
    return 'DeliveryFeeStructure($tierList)';
  }

  @override
  bool operator ==(dynamic o) {
    return o is DeliveryFeeStructure && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}

class FeeTier {
  num threshold;
  num fee;
  FeeTier({
    @required this.threshold,
    @required this.fee,
  });

  String toString() {
    return '(threshold: $threshold, fee: $fee)';
  }
}
