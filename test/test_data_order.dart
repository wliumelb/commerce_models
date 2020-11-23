import 'test_data_address.dart';
import 'test_data_cart.dart';
import 'test_data_voucher.dart';

final orderTestData = [
  {
    'input': {
      'uid': 'orderUid1',
      'userUid': 'user111',
      'merchantUid': 'merchant1',
      'stripeAccountId': 'test-1234',
      'note': 'leave at the door',
      'orderNumber': 1234,
      'status': 'processing',
      'type': 'delivery',
      'name': 'Edwin',
      'email': 'edl@gmail.com',
      'phone': '0412345678',
      'address': addressTestData[0]['input'],
      'storeName': 'Allganic',
      'storePhone': '0481717171',
      'storeAddress': storeAddressTestData['input'],
      'itemList': cartTestData[0]['input'],
      'voucherList': [voucherTestData[0]['input']],
      'deliveryFee': 6,
      'createTime': 1596370200000,
      'deliveryTime': 1596492000000,
      'paymentMethod': 'online',
      'paymentId': '12345',
      'paymentStatus': 'paid'
    },
    'value':
        "OrderModel(uid: orderUid1, userUid: user111, merchantUid: merchant1, stripeAccountId: test-1234, note: leave at the door, orderNumber: 1234, status: processing, type: delivery, name: Edwin, email: edl@gmail.com, phone: 0412345678, address: ${addressTestData[0]['value']}, storeName: Allganic, storePhone: 0481717171, storeAddress: ${storeAddressTestData['value']}, itemList: ${cartModelList[0].itemList}, voucherList: [${voucherTestData[0]['value']}], deliveryFee: 6, createTime: 2020-08-02 22:10, deliveryTime: 2020-08-04 08:00, paymentId: 12345, paymentStatus: paid)",
  },
  {
    'input': {
      'uid': 'orderUid1',
      'userUid': 'user1',
      'merchantUid': 'merchant1',
      'note': 'extra hot please',
      'orderNumber': 1234,
      'status': 'pending',
      'type': 'pickup',
      'name': 'Edwin',
      'email': null,
      'phone': '0412345678',
      'address': null,
      'storeName': 'Allganic',
      'storePhone': '0481717171',
      'storeAddress': storeAddressTestData['input'],
      'itemList': cartTestData[0]['input'],
      'voucherList': [voucherTestData[0]['input']],
      'deliveryFee': 6,
      'createTime': 1596370200000,
      'deliveryTime': null,
      'paymentStatus': 'unpaid',
    },
    'value':
        "OrderModel(uid: orderUid1, userUid: user1, merchantUid: merchant1, stripeAccountId: null, note: extra hot please, orderNumber: 1234, status: pending, type: pickup, name: Edwin, email: null, phone: 0412345678, address: null, storeName: Allganic, storePhone: 0481717171, storeAddress: ${storeAddressTestData['value']}, itemList: ${cartModelList[0].itemList}, voucherList: [${voucherTestData[0]['value']}], deliveryFee: 6, createTime: 2020-08-02 22:10, deliveryTime: null, paymentId: null, paymentStatus: unpaid)",
  }
];
