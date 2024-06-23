import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/screens/fragments/AddPostFragment.dart';
import 'package:tumy_app/screens/fragments/HomeFragment.dart';
import 'package:tumy_app/screens/fragments/NotificationFragment.dart';
import 'package:tumy_app/screens/fragments/ProfileFragment.dart';
import 'package:tumy_app/screens/fragments/SearchFragment.dart';
import 'package:tumy_app/utils/Common.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  Widget getFragment() {
    if (selectedIndex == 0) {
      return HomeFragment();
    } else if (selectedIndex == 1) {
      return SearchFragment();
    } else if (selectedIndex == 2) {
      //return AddPostFragment();
    } else if (selectedIndex == 3) {
      return NotificationFragment();
    } else if (selectedIndex == 4) {
      return ProfileFragment();
    }
    return HomeFragment();
  }

  @override
  void initState() {
    setStatusBarColor(Colors.transparent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      body: getFragment(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/tumy/icons/ic_Home.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    color: context.iconColor)
                .paddingTop(12),
            label: '',
            activeIcon: Image.asset('images/tumy/icons/ic_HomeSelected.png',
                    height: 24, width: 24, fit: BoxFit.cover)
                .paddingTop(12),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/tumy/icons/ic_Search.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    color: context.iconColor)
                .paddingTop(12),
            label: '',
            activeIcon: Image.asset('images/tumy/icons/ic_SearchSelected.png',
                    height: 24, width: 24, fit: BoxFit.cover)
                .paddingTop(12),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/tumy/icons/ic_Plus.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    color: context.iconColor)
                .paddingTop(12),
            label: '',
            activeIcon: Image.asset('images/tumy/icons/ic_PlusSelected.png',
                    height: 24, width: 24, fit: BoxFit.cover)
                .paddingTop(12),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/tumy/icons/ic_Notification.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    color: context.iconColor)
                .paddingTop(12),
            label: '',
            activeIcon: Image.asset(
                    'images/tumy/icons/ic_NotificationSelected.png',
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover)
                .paddingTop(12),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/tumy/icons/ic_User.png',
                    height: 24, width: 24, fit: BoxFit.cover)
                .paddingTop(12),
            label: '',
            activeIcon: Image.asset('images/tumy/icons/ic_UserSelected.png',
                    height: 24, width: 24, fit: BoxFit.cover)
                .paddingTop(12),
          ),
        ],
        onTap: (val) {
          selectedIndex = val;
          setState(() {});
          if (val == 2) {
            selectedIndex = 0;
            setState(() {});
            AddPostFragment().launch(context);
          }
        },
        currentIndex: selectedIndex,
      ),
    );
  }
}
