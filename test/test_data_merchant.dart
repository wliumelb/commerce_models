import 'test_data_address.dart';
import 'test_data_info_section.dart';

final merchantTestData = [
  {
    'input': {
      'uid': 'userUid1',
      'name': 'Edwin',
      'isAnonymous': false,
      'phone': '0444444444',
      'email': 'email@email.com',
      'address': addressList[0].toMap(),
      'photoUrlList': ['photoUrl1, photoUrl2'],
      'info': infoSectionList.map((info) => info.toMap()),
      'productCategoryList': ['fresh', 'meat'],
    },
    'value':
        'uid: userUid1, name: Edwin, phone: 0444444444, email: email@email.com, address: ${addressTestData[0]['value']}, photoUrlList: [photoUrl1, photoUrl2], info: $infoSectionList, productCategoryList: [fresh, meat]',
  }
];
