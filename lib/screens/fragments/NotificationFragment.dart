import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/models/NotificationModel.dart';
import 'package:tumy_app/screens/notification/components/BirthdayNotificationComponent.dart';
import 'package:tumy_app/screens/notification/components/LikeNotificationComponent.dart';
import 'package:tumy_app/screens/notification/components/NewPostNotificationComponent.dart';
import 'package:tumy_app/screens/notification/components/RequestNotificationComponent.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class NotificationFragment extends StatefulWidget {
  @override
  State<NotificationFragment> createState() => _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment> {
  List<NotificationModel> listToday = getNotificationsToday();
  List<NotificationModel> listMonth = getNotificationsThisMonth();
  List<NotificationModel> listEarlier = getNotificationsEarlier();

  Widget getNotificationComponent(
      {String? type, required NotificationModel element}) {
    if (type == NotificationType.like) {
      return LikeNotificationComponent(element: element);
    } else if (type == NotificationType.request) {
      return RequestNotificationComponent(element: element);
    } else if (type == NotificationType.newPost) {
      return NewPostNotificationComponent(element: element);
    } else {
      return BirthdayNotificationComponent(element: element);
    }
  }

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      setStatusBarColor(svGetScaffoldColor());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      appBar: AppBar(
        backgroundColor: svGetScaffoldColor(),
        iconTheme: IconThemeData(color: context.iconColor),
        title: Text('Notification', style: boldTextStyle(size: 20)),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TODAY', style: boldTextStyle()).paddingAll(16),
            Divider(height: 0, indent: 16, endIndent: 16),
            Column(
              children: listToday.map((e) {
                return getNotificationComponent(
                    type: e.notificationType, element: e);
              }).toList(),
            ),
            Text('THIS MONTH', style: boldTextStyle()).paddingAll(16),
            Divider(height: 0, indent: 16, endIndent: 16),
            Column(
              children: listMonth.map((e) {
                return getNotificationComponent(
                    type: e.notificationType, element: e);
              }).toList(),
            ),
            Text('Earlier', style: boldTextStyle()).paddingAll(16),
            Divider(height: 0, indent: 16, endIndent: 16),
            Column(
              children: listEarlier.map((e) {
                return getNotificationComponent(
                    type: e.notificationType, element: e);
              }).toList(),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
