import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/main.dart';
import 'package:tumy_app/screens/addPost/components/PostOptionsComponent.dart';
import 'package:tumy_app/screens/addPost/components/PostTextComponent.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';

class AddPostFragment extends StatefulWidget {
  const AddPostFragment({Key? key}) : super(key: key);

  @override
  State<AddPostFragment> createState() => _AddPostFragmentState();
}

class _AddPostFragmentState extends State<AddPostFragment> {
  String image = '';

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      setStatusBarColor(context.cardColor);
    });
  }

  @override
  void dispose() {
    setStatusBarColor(
        appStore.isDarkMode ? appBackgroundColorDark : AppLayoutBackground);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.iconColor),
        backgroundColor: context.cardColor,
        title: Text('New Post', style: boldTextStyle(size: 20)),
        elevation: 0,
        centerTitle: true,
        actions: [
          AppButton(
            shapeBorder: RoundedRectangleBorder(borderRadius: radius(4)),
            text: 'Post',
            textStyle: secondaryTextStyle(color: Colors.white, size: 10),
            onTap: () {
              svShowShareBottomSheet(context);
            },
            elevation: 0,
            color: AppColorPrimary,
            width: 50,
            padding: EdgeInsets.all(0),
          ).paddingAll(16),
        ],
      ),
      body: SizedBox(
        height: context.height(),
        child: Stack(
          children: [
            PostTextComponent(),
            Positioned(
              child: PostOptionsComponent(),
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}
