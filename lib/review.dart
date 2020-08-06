import 'package:flutter/foundation.dart';

class ReviewModel {
  final String orderUid;

  /// true means satisfied with shopping experience, false means unsatisfied
  final bool shopping;

  /// true means satisfied with delivery, false means unsatisfied
  final bool delivery;

  /// true means satisfied with products received, false means unsatisfied
  final bool products;

  final String comment;

  ReviewModel({
    @required this.orderUid,
    @required this.shopping,
    @required this.delivery,
    @required this.products,
    @required this.comment,
  });

  static ReviewModel fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      orderUid: map['orderUid'],
      shopping: map['shopping'],
      delivery: map['delivery'],
      products: map['products'],
      comment: map['comment'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderUid': this.orderUid,
      'shopping': this.shopping,
      'delivery': this.delivery,
      'products': this.products,
      'comment': this.comment,
    };
  }

  String toString() =>
      'orderUid: $orderUid, shopping: $shopping, delivery: $delivery, products: $products, comment: $comment';

  @override
  bool operator ==(dynamic o) {
    return o is ReviewModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
