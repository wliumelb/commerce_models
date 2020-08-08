final itemTestData = [
  {
    'input': {
      'uid': 'uid123',
      'merchantUid': 'merchant1',
      'category': 'fresh',
      'name': 'Kiwi Fruit',
      'description': 'Big Kiwi Fruit from NZ',
      'photoUrl': 'photoUrl1',
      'price': 7.2,
      'quantity': 1,
    },
    // used to test the fromProduct method
    'productInput': {
      'uid': 'uid123',
      'merchantUid': 'merchant1',
      'category': 'fresh',
      'name': 'Kiwi Fruit',
      'description': 'Big Kiwi Fruit from NZ',
      'photoUrlList': ['photoUrl1', 'photoUrl2'],
      'infoList': [
        {
          'photoUrl': 'photo Url',
        },
        {
          'title': 'Big',
        },
        {
          'text': '5kg box',
        },
      ],
      'price': 7.2,
      'stock': 10,
    },
    'value':
        "uid: uid123, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, description: Big Kiwi Fruit from NZ, photoUrl: photoUrl1, price: 7.2, quantity: 1",
  }
];
