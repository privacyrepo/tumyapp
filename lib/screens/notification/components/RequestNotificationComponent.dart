import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/models/NotificationModel.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';

class RequestNotificationComponent extends StatelessWidget {
  final NotificationModel element;

  RequestNotificationComponent({required this.element});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(element.profileImage.validate(),
                height: 40, width: 40, fit: BoxFit.cover)
            .cornerRadiusWithClipRRect(8),
        8.width,
        Column(
          children: [
            Row(
              children: [
                Text(element.name.validate(), style: boldTextStyle(size: 14)),
                2.width,
                element.isOfficial.validate()
                    ? Image.asset('images/tumy/icons/ic_TickSquare.png',
                        height: 14, width: 14, fit: BoxFit.cover)
                    : Offstage(),
                Text('send request to follow you',
                    style: secondaryTextStyle(color: svGetBodyColor())),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            6.height,
            Text('${element.time.validate()} ago',
                style: secondaryTextStyle(color: svGetBodyColor(), size: 12)),
            16.height,
            Row(
              children: [
                AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius(4)),
                  text: 'Confirm',
                  textStyle: secondaryTextStyle(color: Colors.white, size: 14),
                  onTap: () {},
                  elevation: 0,
                  color: AppColorPrimary,
                  height: 32,
                ),
                16.width,
                AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius(4)),
                  text: 'Delete',
                  textStyle:
                      secondaryTextStyle(color: AppColorPrimary, size: 14),
                  onTap: () {},
                  elevation: 0,
                  color: context.cardColor,
                  height: 32,
                ),
              ],
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ],
    ).paddingAll(16);
  }
}
