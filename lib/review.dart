class ReviewModel {
  /// true means satisfied with shopping experience, false means unsatisfied
  final bool shopping;

  /// true means satisfied with delivery, false means unsatisfied
  final bool delivery;

  /// true means satisfied with products received, false means unsatisfied
  final bool products;

  final String comment;

  ReviewModel({
    this.shopping,
    this.delivery,
    this.products,
    this.comment,
  });

  static ReviewModel fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      shopping: map['shopping'],
      delivery: map['delivery'],
      products: map['products'],
      comment: map['comment'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopping': this.shopping,
      'delivery': this.delivery,
      'products': this.products,
      'comment': this.comment,
    };
  }

  String toString() =>
      'shopping: $shopping, delivery: $delivery, products: $products, comment: $comment';

  @override
  bool operator ==(dynamic o) {
    return o is ReviewModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}
