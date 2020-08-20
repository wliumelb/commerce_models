import 'test_data_address.dart';
import 'test_data_basket.dart';

final dateTimeString = '2020-08-19 11:13';
final timeStamp = DateTime.parse(dateTimeString).millisecondsSinceEpoch;

final userTestData = [
  {
    'input': {
      'uid': 'userUid1',
      'name': 'Edwin',
      'isAnonymous': false,
      'phone': '0444444444',
      'email': 'email@email.com',
      'address': addressTestData[0]['input'],
      'basket': basketTestData[0]['input'],
      'createTime': timeStamp,
    },
    'value':
        'UserModel(uid: userUid1, name: Edwin, isAnonymous: false, phone: 0444444444, email: email@email.com, address: ${addressTestData[0]['value']}, basket: ${basketTestData[0]['value']}, createTime: $dateTimeString)',
  },
  {
    'input': {
      'uid': 'userUid1',
      'name': 'Edwin',
      'isAnonymous': true,
      'phone': null,
      'email': null,
      'address': null,
      'basket': [],
    },
    'value':
        'UserModel(uid: userUid1, name: Edwin, isAnonymous: true, phone: null, email: null, address: null, basket: BasketModel(itemList: [], quantity: 0, totalPrice: 0), createTime: 2020-08-20 10:52)',
  }
];
