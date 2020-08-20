import 'test_data_address.dart';
import 'test_data_basket.dart';
import 'test_data_voucher.dart';

final orderTestData = [
  {
    'input': {
      'uid': 'orderUid1',
      'merchantUid': 'merchant1',
      'note': 'extra hot, please',
      'orderNumber': 1234,
      'status': 'processing',
      'name': 'Edwin',
      'email': 'edl@gmail.com',
      'phone': '0412345678',
      'address': addressTestData[0]['input'],
      'itemList': basketTestData[0]['input'],
      'voucherList': [voucherTestData[0]['input']],
      'deliveryFee': 6,
      'createTime': '2020-08-02 22:10',
      'deliveryTime': '2020-08-04 08:00',
    },
    'value':
        "OrderModel(uid: orderUid1, merchantUid: merchant1, note: extra hot, please, orderNumber: 1234, status: processing, name: Edwin, email: edl@gmail.com, phone: 0412345678, address: ${addressTestData[0]['value']}, itemList: ${basketModelList[0].itemList}, voucherList: [${voucherTestData[0]['value']}], deliveryFee: 6, createTime: 2020-08-02 22:10, deliveryTime: 2020-08-04 08:00)",
  },
  {
    'input': {
      'uid': 'orderUid1',
      'merchantUid': 'merchant1',
      'note': 'leave at the door',
      'orderNumber': 1234,
      'status': 'pending',
      'name': 'Edwin',
      'email': null,
      'phone': '0412345678',
      'address': addressTestData[0]['input'],
      'itemList': basketTestData[0]['input'],
      'voucherList': [voucherTestData[0]['input']],
      'deliveryFee': 6,
      'createTime': '2020-08-02 22:10',
      'deliveryTime': null,
    },
    'value':
        "OrderModel(uid: orderUid1, merchantUid: merchant1, note: leave at the door, orderNumber: 1234, status: pending, name: Edwin, email: null, phone: 0412345678, address: ${addressTestData[0]['value']}, itemList: ${basketModelList[0].itemList}, voucherList: [${voucherTestData[0]['value']}], deliveryFee: 6, createTime: 2020-08-02 22:10, deliveryTime: null)",
  }
];
