import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/models/ForumTopicModel.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class ForumTopicComponent extends StatefulWidget {
  final bool isFavTab;

  ForumTopicComponent({required this.isFavTab});

  @override
  State<ForumTopicComponent> createState() => _ForumTopicComponentState();
}

class _ForumTopicComponentState extends State<ForumTopicComponent> {
  List<ForumTopicModel> topicsList = getTopicsList();
  List<ForumTopicModel> tempList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    tempList.clear();
    if (widget.isFavTab) {
      topicsList.forEach((element) {
        if (element.isFav.validate()) {
          tempList.add(element);
        }
        setState(() {});
      });
    } else {
      topicsList.forEach((element) {
        if (!element.isFav.validate()) {
          tempList.add(element);
        }
        setState(() {});
      });
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: context.cardColor, borderRadius: radius(AppCommonRadius)),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Row(
                    children: [
                      Image.asset('images/tumy/icons/ic_2User.png',
                          height: 16, width: 16, fit: BoxFit.cover),
                      8.width,
                      Text(tempList[index].name.validate(),
                          style: secondaryTextStyle(color: svGetBodyColor())),
                      20.width,
                      Image.asset('images/tumy/icons/ic_Folder.png',
                          height: 16, width: 16, fit: BoxFit.cover),
                      8.width,
                      Text('${tempList[index].domain.validate()}',
                          style: secondaryTextStyle(color: svGetBodyColor())),
                    ],
                  ),
                  if (tempList[index].isFav.validate())
                    Image.asset('images/tumy/icons/ic_HeartFilled.png',
                        height: 16, width: 16, fit: BoxFit.fill),
                ],
              ),
              12.height,
              Text(tempList[index].title.validate(), style: boldTextStyle()),
              Divider(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('POST',
                          style: secondaryTextStyle(
                              size: 12, color: svGetBodyColor())),
                      4.height,
                      Text(tempList[index].postNo.validate(),
                          style: boldTextStyle(size: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('VOICES',
                          style: secondaryTextStyle(
                              size: 12, color: svGetBodyColor())),
                      4.height,
                      Text(tempList[index].voicesNo.validate(),
                          style: boldTextStyle(size: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('FRESHNESS',
                          style: secondaryTextStyle(
                              size: 12, color: svGetBodyColor())),
                      4.height,
                      Text(tempList[index].freshness.validate(),
                          style: boldTextStyle(size: 14)),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
      itemCount: tempList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
