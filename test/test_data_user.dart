import 'test_data_address.dart';
import 'test_data_cart.dart';

final dateTimeString = '2020-08-19 11:13';
final timestamp = DateTime.parse(dateTimeString).millisecondsSinceEpoch;

final dateTimeString2 = '2020-08-30 12:50';
final timestamp2 = DateTime.parse(dateTimeString2).millisecondsSinceEpoch;

final userTestData = [
  {
    'input': {
      'uid': 'userUid1',
      'stripeCustomerId': 'sp_123',
      'name': 'Edwin',
      'isAnonymous': false,
      'phone': '0444444444',
      'email': 'email@email.com',
      'address': addressTestData[0]['input'],
      'cart': cartTestData[0]['input'],
      'createTime': timestamp,
      'lastActiveTime': timestamp2,
    },
    'value':
        'UserModel(uid: userUid1, stripeCustomerId: sp_123, name: Edwin, isAnonymous: false, phone: 0444444444, email: email@email.com, address: ${addressTestData[0]['value']}, createTime: $dateTimeString, lastActiveTime: $dateTimeString2)',
  },
  {
    'input': {
      'uid': 'userUid1',
      'name': 'Edwin',
      'isAnonymous': true,
      'phone': null,
      'email': null,
      'address': null,
      'cart': [],
    },
    'value':
        'UserModel(uid: userUid1, stripeCustomerId: null, name: Edwin, isAnonymous: true, phone: null, email: null, address: null, createTime: 2020-08-20 10:52, lastActiveTime: 2020-08-20 10:52)',
  }
];
