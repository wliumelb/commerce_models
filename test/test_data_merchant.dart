import 'delivery_fee_structure.dart';
import 'test_data_address.dart';
import 'test_data_info_section.dart';

final dateTimeString = '2020-08-19 11:13';
final timeStamp = DateTime.parse(dateTimeString).millisecondsSinceEpoch;

final merchantTestData = [
  {
    'input': {
      'uid': 'userUid1',
      'name': 'Edwin',
      'description': "This is Edwin's shop",
      'phone': '0444444444',
      'email': 'email@email.com',
      'orderTypeList': ['delivery', 'pickup'],
      'paymentMethodList': ['online', 'cash'],
      'address': addressList[0].toMap(),
      'photoUrlList': ['photoUrl1, photoUrl2'],
      'infoList': infoSectionList.map((info) => info.toMap()),
      'productCategoryList': ['fresh', 'meat'],
      'createTime': timeStamp,
      'deliveryFeeStructure': deliveryFeeStructureTestData[0]['input'],
    },
    'value':
        "MerchantModel(uid: userUid1, name: Edwin, description: This is Edwin's shop, phone: 0444444444, email: email@email.com, orderTypeList: [OrderType.delivery, OrderType.pickup], paymentMethodList: [PaymentMethod.online, PaymentMethod.cash], address: ${addressTestData[0]['value']}, photoUrlList: [photoUrl1, photoUrl2], infoList: $infoSectionList, productCategoryList: [fresh, meat], createTime: $dateTimeString, deliveryFeeStructure: ${deliveryFeeStructureTestData[0]['value']})",
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
        'MerchantModel(uid: uid111, name: Edwin Shop, description: null, phone: null, email: email@email.com, orderTypeList: [], paymentMethodList: [], address: null, photoUrlList: [], infoList: [], productCategoryList: [], createTime: 2020-08-20 10:52, deliveryFeeStructure: DeliveryFeeStructure([]))',
  }
];
