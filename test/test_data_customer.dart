final customerTestData = [
  {
    'input': {
      'uid': 'user1',
      'phone': '0425123456',
      'lastVisit': 1606869559666,
      'cart': [
        {
          'uid': 'cartItem1',
          'merchantUid': 'merchant1',
          'category': 'fresh',
          'name': 'Kiwi Fruit',
          'description': 'Big Kiwi Fruit from NZ',
          'photoUrl': 'photoUrl1',
          'price': 8.5,
          'quantity': 4,
        },
        {
          'uid': 'cartItem2',
          'merchantUid': 'merchant1',
          'category': 'meat',
          'name': 'Wagu Beaf',
          'description': 'Best beaf',
          'photoUrl': 'photoUrl2',
          'price': 38,
          'quantity': 1,
        },
      ]
    },
    'value':
        "CustomerModel(uid: user1, phone: 0425123456, cart: CartModel(itemList: [ItemModel(uid: cartItem1, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, description: Big Kiwi Fruit from NZ, photoUrl: photoUrl1, price: 8.5, quantity: 4), ItemModel(uid: cartItem2, merchantUid: merchant1, name: Wagu Beaf, category: meat, description: Best beaf, photoUrl: photoUrl2, price: 38, quantity: 1)], quantity: 5, totalPrice: 72.0), lastVisit: 2020-12-02 11:39:19)",
  },
  {
    'input': {
      'uid': 'user2',
      'phone': '0421234567',
      'lastVisit': 1606869259666,
      'cart': [
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
      ]
    },
    'value':
        "CustomerModel(uid: user2, phone: 0421234567, cart: CartModel(itemList: [ItemModel(uid: itemUid1, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, description: Big Kiwi Fruit from NZ, photoUrl: photoUrl1, price: 8.5, quantity: 4), ItemModel(uid: itemUid2, merchantUid: merchant1, name: Wagu Beaf, category: meat, description: Best beaf, photoUrl: photoUrl2, price: 38, quantity: 1)], quantity: 5, totalPrice: 72.0), lastVisit: 2020-12-02 11:34:19)",
  },
  {
    'input': {
      'uid': 'user3',
      'phone': '0412345678',
      'lastVisit': 1606869300000,
      'cart': [
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
      ]
    },
    'value':
        "CustomerModel(uid: user3, phone: 0412345678, cart: CartModel(itemList: [ItemModel(uid: itemUid1, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, description: Big Kiwi Fruit from NZ, photoUrl: photoUrl1, price: 8.5, quantity: 4), ItemModel(uid: itemUid2, merchantUid: merchant1, name: Wagu Beaf, category: meat, description: Best beaf, photoUrl: photoUrl2, price: 38, quantity: 1)], quantity: 5, totalPrice: 72.0), lastVisit: 2020-12-02 11:35:00)",
  },
  {
    // test empty cart
    'input': {
      'uid': 'user3',
      'lastVisit': 1606869300000,
    },
    'value':
        "CustomerModel(uid: user3, phone: null, cart: CartModel(itemList: [], quantity: 0, totalPrice: 0), lastVisit: 2020-12-02 11:35:00)",
  },
];
