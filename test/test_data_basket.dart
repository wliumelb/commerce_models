import 'package:commerce_models/basket.dart';

final basketTestData = [
  // add different item from same merchant
  {
    'input': [
      {
        'uid': 'basketItem1',
        'merchantUid': 'merchant1',
        'category': 'fresh',
        'name': 'Kiwi Fruit',
        'description': 'Big Kiwi Fruit from NZ',
        'photoUrl': 'photoUrl1',
        'price': 8.5,
        'quantity': 4,
      },
      {
        'uid': 'basketItem2',
        'merchantUid': 'merchant1',
        'category': 'meat',
        'name': 'Wagu Beaf',
        'description': 'Best beaf',
        'photoUrl': 'photoUrl2',
        'price': 38,
        'quantity': 1,
      },
    ],
    // this one add an item not already in the basket
    'addedItemInput': {
      'uid': 'addedBasketItem1',
      'merchantUid': 'merchant1',
      'category': 'fresh',
      'name': 'Eggplant',
      'description': 'Fresh eggplant',
      'photoUrl': 'photoUrl3',
      'price': 6,
      'quantity': 1,
    },
    'value':
        "itemList: [uid: basketItem1, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, description: Big Kiwi Fruit from NZ, photoUrl: photoUrl1, price: 8.5, quantity: 4, uid: basketItem2, merchantUid: merchant1, name: Wagu Beaf, category: meat, description: Best beaf, photoUrl: photoUrl2, price: 38, quantity: 1], quantity: 5, totalPrice: 72.0",
  },
  {
    'input': [
      {
        'uid': 'itemUid1',
        'merchantUid': 'merchant1',
        'category': 'fresh',
        'name': 'Kiwi Fruit',
        'description': 'Big Kiwi Fruit from NZ',
        'photoUrl': 'photoUrl1',
        'price': 8.5,
        'quantity': 4,
      },
      {
        'uid': 'itemUid2',
        'merchantUid': 'merchant1',
        'category': 'meat',
        'name': 'Wagu Beaf',
        'description': 'Best beaf',
        'photoUrl': 'photoUrl2',
        'price': 38,
        'quantity': 1,
      },
    ],
    // this one add an item already in the basket
    'addedItemInput': {
      'uid': 'itemUid1',
      'merchantUid': 'merchant1',
      'category': 'fresh',
      'name': 'Kiwi Fruit',
      'description': 'Big Kiwi Fruit from NZ',
      'photoUrl': 'photoUrl1',
      'price': 8.5,
      'quantity': 1,
    },
    'value':
        "itemList: [uid: itemUid1, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, description: Big Kiwi Fruit from NZ, photoUrl: photoUrl1, price: 8.5, quantity: 4, uid: itemUid2, merchantUid: merchant1, name: Wagu Beaf, category: meat, description: Best beaf, photoUrl: photoUrl2, price: 38, quantity: 1], quantity: 5, totalPrice: 72.0",
  },
  {
    'input': [
      {
        'uid': 'itemUid1',
        'merchantUid': 'merchant1',
        'category': 'fresh',
        'name': 'Kiwi Fruit',
        'description': 'Big Kiwi Fruit from NZ',
        'photoUrl': 'photoUrl1',
        'price': 8.5,
        'quantity': 4,
      },
      {
        'uid': 'itemUid2',
        'merchantUid': 'merchant1',
        'category': 'meat',
        'name': 'Wagu Beaf',
        'description': 'Best beaf',
        'photoUrl': 'photoUrl2',
        'price': 38,
        'quantity': 1,
      },
    ],
    // this one add an item already in the basket
    'addedItemInput': {
      'uid': 'itemUid3',
      'merchantUid': 'merchant2',
      'category': 'fresh',
      'name': 'Watermelon',
      'description': 'Big watermelon',
      'photoUrl': 'photoUrl2',
      'price': 4,
      'quantity': 1,
    },
    'value':
        "itemList: [uid: itemUid1, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, description: Big Kiwi Fruit from NZ, photoUrl: photoUrl1, price: 8.5, quantity: 4, uid: itemUid2, merchantUid: merchant1, name: Wagu Beaf, category: meat, description: Best beaf, photoUrl: photoUrl2, price: 38, quantity: 1], quantity: 5, totalPrice: 72.0",
  },
];

final List<BasketModel> basketModelList =
    basketTestData.map((map) => BasketModel.fromMapList(map['input'])).toList();
