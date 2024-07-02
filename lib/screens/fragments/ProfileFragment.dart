import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:tumy_app/main.dart';
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';
import 'package:tumy_app/screens/home/components/StoryComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfileHeaderComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfilePostsComponent.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';
import 'package:tumy_app/utils/Colors.dart';


class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  AuthProvider? authProvider; // Declare AuthProvider variable

  @override
  void initState() {
    setStatusBarColor(Colors.transparent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context); // Initialize authProvider

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
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeaderComponent(authProvider?.currentUser?.avatar), // Use ProfileHeaderComponent to display user info
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(authProvider?.currentUser?.name ?? '', style: boldTextStyle(size: 20)), // Use user's name
                  4.width,
                  Image.network(
                    authProvider?.currentUser?.avatar ?? '', // Use user's avatar URL
                    height: 14,
                    width: 14,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Text(authProvider?.currentUser?.email ?? '', // Use user's email
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
                      Text(authProvider?.currentUser?.following.length.toString() ?? '', style: boldTextStyle(size: 18)), // Replace with user's posts count
                    ],
                  ),
                  Column(
                    children: [
                      Text('Followers',
                          style: secondaryTextStyle(
                              color: svGetBodyColor(), size: 12)),
                      4.height,
                      Text(authProvider?.currentUser?.followers.length.toString() ?? '', style: boldTextStyle(size: 18)), // Replace with user's followers count
                    ],
                  ),

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
