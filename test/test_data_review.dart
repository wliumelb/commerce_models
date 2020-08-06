final reviewTestData = [
  {
    'input': {
      'orderUid': 'order1',
      'shopping': true,
      'delivery': true,
      'products': true,
      'comment': 'Very Good',
    },
    'value':
        'orderUid: order1, shopping: true, delivery: true, products: true, comment: Very Good',
  },
  {
    'input': {
      'orderUid': 'order2',
      'shopping': true,
      'delivery': false,
      'products': true,
      'comment': 'Delivery is slow',
    },
    'value':
        'orderUid: order2, shopping: true, delivery: false, products: true, comment: Delivery is slow',
  }
];
