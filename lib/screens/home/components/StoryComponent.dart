import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/models/StoryModel.dart';
import 'package:tumy_app/screens/home/screens/StoryScreen.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class StoryComponent extends StatefulWidget {
  @override
  State<StoryComponent> createState() => _StoryComponentState();
}

class _StoryComponentState extends State<StoryComponent> {
  List<StoryModel> storyList = getStories();
  File? image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: AppColorPrimary,
                  borderRadius: radius(AppCommonRadius),
                ),
                child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () async {
                      image = await svGetImageSource();
                    }),
              ),
              10.height,
              Text('Your Story',
                  style: secondaryTextStyle(
                      size: 12,
                      color: context.iconColor,
                      weight: FontWeight.w500)),
            ],
          ),
          HorizontalList(
            spacing: 16,
            itemCount: storyList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    child: Image.asset(
                      storyList[index].profileImage.validate(),
                      height: 58,
                      width: 58,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(AppCommonRadius),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColorPrimary, width: 2),
                      borderRadius: radius(14),
                    ),
                  ).onTap(() {
                    StoryScreen(story: storyList[index]).launch(context);
                  }),
                  10.height,
                  Text(storyList[index].name.validate(),
                      style: secondaryTextStyle(
                          size: 12,
                          color: context.iconColor,
                          weight: FontWeight.w500)),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
