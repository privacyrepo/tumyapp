import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image;
import 'package:tumy_app/screens/home/components/StoryComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfileHeaderComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfilePostsComponent.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';


class ProfilePage extends StatelessWidget {
  final User user; // Accept a user object

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      appBar: AppBar(
        backgroundColor: svGetScaffoldColor(),
        title: Text(user.name, style: boldTextStyle(size: 20)),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: context.iconColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeaderComponent(user.avatar), // Pass user's avatar to ProfileHeaderComponent
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.name, style: boldTextStyle(size: 20)), // Use user's name
                4.width,
                Image.network(
                  user.avatar, // Use user's avatar URL
                  height: 14,
                  width: 14,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Text(user.email, style: secondaryTextStyle(color: svGetBodyColor())), // Use user's email
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
                    Text('Posts', style: secondaryTextStyle(color: svGetBodyColor(), size: 12)),
                    4.height,
                    Text(user.posts.length.toString(), style: boldTextStyle(size: 18)), // Replace with user's posts count
                  ],
                ),
                Column(
                  children: [
                    Text('Followers', style: secondaryTextStyle(color: svGetBodyColor(), size: 12)),
                    4.height,
                    Text(user.followers.length.toString(), style: boldTextStyle(size: 18)), // Replace with user's followers count
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
                  Text('Your Stories', style: boldTextStyle(size: 14)).paddingSymmetric(horizontal: 16),
                  StoryComponent(),
                ],
              ),
            ),
            16.height,
            ProfilePostsComponent(user:user),
            16.height,
          ],
        ),
      ),
    );
  }
}
