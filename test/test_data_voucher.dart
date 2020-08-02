final voucherTestData = [
  {
    'input': {
      'uid': 'voucherUid1',
      'userUid': 'user1',
      'sharerUid': 'user2',
      'value': 5,
      'threshold': 20,
      'expireDate': '2020-08-10 14:00',
      'isValid': true,
    },
    'value':
        "uid: voucherUid1, userUid: user1, sharerUid: user2, value: 5, threshold: 20, expireDate: 2020-08-10 14:00, isValid: true",
  },
  {
    'input': {
      'uid': 'voucherUid2',
      'userUid': 'user1111',
      'sharerUid': 'user2222',
      'value': 15,
      'threshold': 50,
      'expireDate': '2020-09-01 00:00',
      'isValid': false,
    },
    'value':
        "uid: voucherUid2, userUid: user1111, sharerUid: user2222, value: 15, threshold: 50, expireDate: 2020-09-01 00:00, isValid: false",
  },
];
