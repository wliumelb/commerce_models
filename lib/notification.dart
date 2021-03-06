import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NotificationModel {
  final String uid;
  final String userUid;
  final String title;
  final String body;
  final NotificationType type;
  // uid of item, order or voucher
  final String targetUid;
  final DateTime sendTime;
  final DateTime viewedTime;
  final String photoUrl;
  // if notification is viewed by the user
  final bool isViewed;

  NotificationModel({
    @required this.uid,
    @required this.userUid,
    @required this.title,
    @required this.body,
    @required this.sendTime,
    @required this.viewedTime,
    @required this.type,
    @required this.targetUid,
    @required this.photoUrl,
    @required this.isViewed,
  });
  static NotificationModel fromMap(Map<String, dynamic> map) {
    NotificationType type;
    switch (map['type']) {
      case 'item':
        type = NotificationType.item;
        break;
      case 'order':
        type = NotificationType.order;
        break;
      case 'voucher':
        type = NotificationType.voucher;
        break;
    }

    final viewedTime = map['viewedTime'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['viewedTime']);
    return NotificationModel(
      uid: map['uid'],
      userUid: map['userUid'],
      title: map['title'],
      body: map['body'],
      sendTime: DateTime.fromMillisecondsSinceEpoch(map['sendTime']),
      viewedTime: viewedTime,
      type: type,
      targetUid: map['targetUid'],
      photoUrl: map['photoUrl'],
      isViewed: map['isViewed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'userUid': this.userUid,
      'title': this.title,
      'body': this.body,
      'sendTime': this.sendTime?.millisecondsSinceEpoch,
      'viewedTime': this.viewedTime?.millisecondsSinceEpoch,
      'type': this.type.string,
      'targetUid': this.targetUid,
      'photoUrl': this.photoUrl,
      'isViewed': this.isViewed,
    };
  }

  Map<String, dynamic> setAsViewedReturnMap() {
    if (isViewed) {
      return this.toMap();
    } else {
      return {
        ...toMap(),
        'isViewed': true,
        'viewedTime': DateTime.now().millisecondsSinceEpoch,
      };
    }
  }

  String toString() {
    final sendTimeString = DateFormat('yyyy-MM-dd HH:mm').format(sendTime);
    final viewedTimeString = viewedTime == null
        ? null
        : DateFormat('yyyy-MM-dd HH:mm').format(viewedTime);
    return 'NotificationModel(uid: $uid, userUid: $userUid, title: $title, body: $body, sendTime: $sendTimeString, viewedTime: $viewedTimeString, type: ${type.string}, targetUid: $targetUid, photoUrl: $photoUrl, isViewed: $isViewed)';
  }

  @override
  bool operator ==(dynamic o) {
    return o is NotificationModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => this.toString().hashCode;
}

// types of notifications: recommendation of item, change of order, offer of voucher
enum NotificationType {
  item,
  order,
  voucher,
}

extension NotificationTypeExt on NotificationType {
  String get string => describeEnum(this);
}
