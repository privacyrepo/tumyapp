import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/models/ForumRepliesModel.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class ForumRepliesComponent extends StatelessWidget {
  final List<ForumRepliesModel> repliesList = getRepliesList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            color: context.cardColor, borderRadius: radius(AppCommonRadius)),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('images/tumy/icons/ic_Calendar.png',
                    height: 16,
                    width: 16,
                    fit: BoxFit.cover,
                    color: context.iconColor),
                8.width,
                Text(repliesList[index].date.validate(),
                        style: secondaryTextStyle(
                            color: svGetBodyColor(), weight: FontWeight.w600))
                    .expand(),
                Text('#${repliesList[index].hashTagNo.validate()}',
                    style: secondaryTextStyle(
                        color: AppColorPrimary, weight: FontWeight.w700)),
              ],
            ),
            Divider(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      repliesList[index].profileImage.validate(),
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(8),
                    20.width,
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(repliesList[index].name.validate(),
                                style: boldTextStyle()),
                            6.width,
                            repliesList[index].isOfficial.validate()
                                ? Image.asset(
                                    'images/tumy/icons/ic_TickSquare.png',
                                    height: 14,
                                    width: 14,
                                    fit: BoxFit.cover)
                                : Offstage(),
                          ],
                          mainAxisSize: MainAxisSize.min,
                        ),
                        6.height,
                        Text(repliesList[index].subTitle.validate(),
                            style: secondaryTextStyle(color: svGetBodyColor())),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColorPrimary.withAlpha(30),
                      borderRadius: radius(AppContainerRadius)),
                  child: Text('Keymaster',
                      style: boldTextStyle(size: 14, color: AppColorPrimary)),
                )
              ],
            ),
            24.height,
            Text(repliesList[index].description.validate(),
                style: secondaryTextStyle(color: svGetBodyColor()))
          ],
        ),
      ),
      itemCount: repliesList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
