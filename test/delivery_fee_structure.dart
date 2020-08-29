final deliveryFeeStructureTestData = [
  // add different item from same merchant
  {
    'input': [
      {
        'threshold': 0,
        'fee': 12,
      },
      {
        'threshold': 50,
        'fee': 6,
      },
      {
        'threshold': 100,
        'fee': 0,
      },
    ],
    'tests': [
      [0, 12],
      [1, 12],
      [2.8, 12],
      [49.9, 12],
      [50, 6],
      [97, 6],
      [101.11, 0]
    ],
    'added': {
      'threshold': 30,
      'fee': 8,
    },
    'new_tests': [
      [29.55, 12],
      [30.60, 8],
    ],
    'value':
        'DeliveryFeeStructure([(threshold: 0, fee: 12), (threshold: 50, fee: 6), (threshold: 100, fee: 0)])',
  },
];
