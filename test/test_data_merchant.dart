import 'test_data_address.dart';
import 'test_data_info_section.dart';

final merchantTestData = [
  {
    'input': {
      'uid': 'userUid1',
      'name': 'Edwin',
      'description': "This is Edwin's shop",
      'phone': '0444444444',
      'email': 'email@email.com',
      'address': addressList[0].toMap(),
      'photoUrlList': ['photoUrl1, photoUrl2'],
      'infoList': infoSectionList.map((info) => info.toMap()),
      'productCategoryList': ['fresh', 'meat'],
    },
    'value':
        "uid: userUid1, name: Edwin, description: This is Edwin's shop, phone: 0444444444, email: email@email.com, address: ${addressTestData[0]['value']}, photoUrlList: [photoUrl1, photoUrl2], infoList: $infoSectionList, productCategoryList: [fresh, meat]",
  },
  {
    'input': {
      'uid': 'uid111',
      'name': 'Edwin Shop',
      'phone': null,
      'email': 'email@email.com',
      'address': null,
      'photoUrlList': [],
      'infoList': [],
      'productCategoryList': [],
    },
    'value':
        'uid: uid111, name: Edwin Shop, description: null, phone: null, email: email@email.com, address: null, photoUrlList: [], infoList: [], productCategoryList: []',
  }
];
