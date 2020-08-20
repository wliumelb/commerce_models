final notificationTestData = [
  {
    'input': {
      'uid': 'notif1',
      'title': 'Order Received',
      'body': 'Your order is being processed',
      'sendTime': '2020-08-03 11:29',
      'viewedTime': null,
      'type': 'order',
      'targetUid': 'targetUid1',
      'photoUrl': 'photoUrl1',
      'isViewed': false,
    },
    'value':
        'NotificationModel(uid: notif1, title: Order Received, body: Your order is being processed, sendTime: 2020-08-03 11:29, viewedTime: null, type: order, targetUid: targetUid1, photoUrl: photoUrl1, isViewed: false)',
  },
  {
    'input': {
      'uid': 'notif2',
      'title': 'Order Dispatched',
      'body': 'Your order is on the way to your home',
      'sendTime': '2020-08-03 12:20',
      'viewedTime': '2020-08-04 10:11',
      'type': 'order',
      'targetUid': 'targetUid2',
      'photoUrl': 'photoUrl2',
      'isViewed': true,
    },
    'value':
        'NotificationModel(uid: notif2, title: Order Dispatched, body: Your order is on the way to your home, sendTime: 2020-08-03 12:20, viewedTime: 2020-08-04 10:11, type: order, targetUid: targetUid2, photoUrl: photoUrl2, isViewed: true)',
  }
];
