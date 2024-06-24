import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/screens/auth/components/LoginInComponent.dart';
import 'package:tumy_app/screens/auth/components/SignUpComponent.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

import '../../../utils/Colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      setStatusBarColor(svGetScaffoldColor());
    });
  }

  Widget getFragment() {
    if (selectedIndex == 0)
      return LoginInComponent(
        callback: () {
          selectedIndex = 1;
          setState(() {});
        },
      );
    else
      return SignUpComponent(
        callback: () {
          selectedIndex = 0;
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    setStatusBarColor(svGetScaffoldColor());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      body: Column(
        children: [
          SizedBox(height: context.statusBarHeight + 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/tumy/svAppIcon.png',
                  height: 40, width: 40, fit: BoxFit.cover),
              8.width,
              Text(svAppName,
                  style: primaryTextStyle(
                      color: AppColorPrimary,
                      size: 28,
                      weight: FontWeight.w500,
                      fontFamily: svFontRoboto)),
            ],
          ),
          40.height,
          svHeaderContainer(
            context: context,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text('LOGIN',
                      style: boldTextStyle(
                          color: selectedIndex == 0
                              ? Colors.white
                              : Colors.white54,
                          size: 16)),
                  onPressed: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                ),
                TextButton(
                  child: Text('SIGNUP',
                      style: boldTextStyle(
                          color: selectedIndex == 1
                              ? Colors.white
                              : Colors.white54,
                          size: 16)),
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          getFragment().expand(),
        ],
      ),
    );
  }
}
