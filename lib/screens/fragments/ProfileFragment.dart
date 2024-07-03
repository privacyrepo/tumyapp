import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/main.dart';
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';
import 'package:tumy_app/screens/home/components/StoryComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfileHeaderComponent.dart';
import 'package:tumy_app/screens/profile/components/ProfilePostsComponent.dart';
import 'package:tumy_app/screens/profile/screens/ProfilePage.dart'; // Import ProfilePage
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';
import 'package:tumy_app/utils/Colors.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  AuthProvider? authProvider;

  @override
  void initState() {
    setStatusBarColor(Colors.transparent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);

    // Debug prints to check the values
    print('Current user: ${authProvider?.currentUser}');
    print('Current user avatar: ${authProvider?.currentUser?.avatar}');
    print('Current user name: ${authProvider?.currentUser?.name}');
    print('Current user email: ${authProvider?.currentUser?.email}');
    print('Current user posts: ${authProvider?.currentUser?.posts}');
    print('Current user followers: ${authProvider?.currentUser?.followers}');

    if (authProvider?.currentUser == null) {
      // Handle the null case here
      return Center(
        child: Text('User data is not available'),
      );
    }

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
              ProfileHeaderComponent(authProvider?.currentUser?.avatar ?? ''), // Pass current user's avatar
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(authProvider?.currentUser?.name ?? '', style: boldTextStyle(size: 20)), // Use current user's name
                  4.width,
                  GestureDetector(
                    onTap: () {
                      if (authProvider?.currentUser != null) {
                        // Navigate to ProfilePage of the current user
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(user: authProvider!.currentUser!),
                          ),
                        );
                      } else {
                        print('Current user is null');
                      }
                    },
                    child: Image.network(
                      authProvider?.currentUser?.avatar ?? '', // Use current user's avatar URL
                      height: 14,
                      width: 14,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Text(authProvider?.currentUser?.email ?? '', style: secondaryTextStyle(color: svGetBodyColor())), // Use current user's email
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
                      Text(authProvider?.currentUser?.posts.length.toString() ?? '', style: boldTextStyle(size: 18)), // Replace with current user's posts count
                    ],
                  ),
                  Column(
                    children: [
                      Text('Followers', style: secondaryTextStyle(color: svGetBodyColor(), size: 12)),
                      4.height,
                      Text(authProvider?.currentUser?.followers.length.toString() ?? '', style: boldTextStyle(size: 18)), // Replace with current user's followers count
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
              ProfilePostsComponent(user: authProvider!.currentUser!), // Pass current user's ID to fetch posts
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
