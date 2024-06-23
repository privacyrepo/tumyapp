import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/screens/home/components/HomeDrawerComponent.dart';
import 'package:tumy_app/screens/home/components/PostComponent.dart';
import 'package:tumy_app/screens/home/components/StoryComponent.dart';
import 'package:tumy_app/utils/Common.dart';

class HomeFragment extends StatefulWidget {
  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  File? image;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      setStatusBarColor(svGetScaffoldColor());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: svGetScaffoldColor(),
      appBar: AppBar(
        backgroundColor: svGetScaffoldColor(),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'images/tumy/icons/ic_More.png',
            width: 18,
            height: 18,
            fit: BoxFit.cover,
            color: context.iconColor,
          ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text('Home', style: boldTextStyle(size: 18)),
        actions: [
          IconButton(
            icon: Image.asset(
              'images/tumy/icons/ic_Camera.png',
              width: 24,
              height: 22,
              fit: BoxFit.fill,
              color: context.iconColor,
            ),
            onPressed: () async {
              image = await svGetImageSource();
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: context.cardColor,
        child: HomeDrawerComponent(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            16.height,
            StoryComponent(),
            16.height,
            PostComponent(),
            16.height,
          ],
        ),
      ),
    );
  }
}
