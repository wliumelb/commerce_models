import 'test_data_address.dart';
import 'test_data_basket.dart';

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
    },
    'value':
        'uid: userUid1, name: Edwin, isAnonymous: false, phone: 0444444444, email: email@email.com, address: ${addressTestData[0]['value']}, basket: ${basketTestData[0]['value']}',
  }
];
