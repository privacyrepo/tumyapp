import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/main.dart';
import 'package:tumy_app/screens/home/components/StoryComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfileHeaderComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfilePostsComponent.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

import '../../utils/Colors.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  void initState() {
    setStatusBarColor(Colors.transparent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: svGetScaffoldColor(),
        appBar: AppBar(
          backgroundColor: svGetScaffoldColor(),
          title: Text('Profile', style: boldTextStyle(size: 20)),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: context.iconColor),
          actions: [
            Switch(
              onChanged: (val) {
                appStore.toggleDarkMode(value: val);
              },
              value: appStore.isDarkMode,
              activeColor: AppColorPrimary,
            ),
            //IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeaderComponent(),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Manding boss', style: boldTextStyle(size: 20)),
                  4.width,
                  Image.asset('images/tumy/icons/ic_TickSquare.png',
                      height: 14, width: 14, fit: BoxFit.cover),
                ],
              ),
              Text('@splatterui',
                  style: secondaryTextStyle(color: svGetBodyColor())),
              24.height,
              AppButton(
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(4)),
                text: 'Following',
                textStyle: boldTextStyle(color: Colors.white),
                onTap: () {},
                elevation: 0,
                color: AppColorPrimary,
              ),
              24.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('Posts',
                          style: secondaryTextStyle(
                              color: svGetBodyColor(), size: 12)),
                      4.height,
                      Text('1,1286', style: boldTextStyle(size: 18)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Followers',
                          style: secondaryTextStyle(
                              color: svGetBodyColor(), size: 12)),
                      4.height,
                      Text('127k', style: boldTextStyle(size: 18)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Views',
                          style: secondaryTextStyle(
                              color: svGetBodyColor(), size: 12)),
                      4.height,
                      Text('1156m', style: boldTextStyle(size: 18)),
                    ],
                  )
                ],
              ),
              16.height,
              Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: radius(AppCommonRadius)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    Text('Your Stories', style: boldTextStyle(size: 14))
                        .paddingSymmetric(horizontal: 16),
                    StoryComponent(),
                  ],
                ),
              ),
              16.height,
              ProfilePostsComponent(),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
