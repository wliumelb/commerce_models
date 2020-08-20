final productTestData = [
  {
    'input': {
      'uid': 'uid123',
      'merchantUid': 'merchant1',
      'category': 'fresh',
      'isAvailable': true,
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
      'sold': 20,
    },
    'value':
        "ProductModel(uid: uid123, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, isAvailable: true, description: Big Kiwi Fruit from NZ, photoUrlList: [photoUrl1, photoUrl2], infoList: [InfoSectionModel(title: none, photoUrl: photo Url, text: none), InfoSectionModel(title: Big, photoUrl: none, text: none), InfoSectionModel(title: none, photoUrl: none, text: 5kg box)], price: 7.2, stock: 10, sold: 20)",
  },
  {
    'input': {
      'uid': 'uid123',
      'merchantUid': 'merchant1',
      'category': 'fresh',
      'isAvailable': true,
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
        "ProductModel(uid: uid123, merchantUid: merchant1, name: Kiwi Fruit, category: fresh, isAvailable: true, description: Big Kiwi Fruit from NZ, photoUrlList: [photoUrl1, photoUrl2], infoList: [InfoSectionModel(title: none, photoUrl: photo Url, text: none), InfoSectionModel(title: Big, photoUrl: none, text: none), InfoSectionModel(title: none, photoUrl: none, text: 5kg box)], price: 7.2, stock: 10, sold: 0)",
  }
];
