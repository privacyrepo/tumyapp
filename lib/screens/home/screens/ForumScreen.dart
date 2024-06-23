import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/screens/home/components/ForumRepliesComponent.dart';
import 'package:tumy_app/screens/home/components/ForumTopicComponent.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List<String> tabList = ['Topics', 'Replies', 'Engagement', 'Favourite'];

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget getTabContainer() {
    if (selectedTab == 0) {
      return ForumTopicComponent(isFavTab: false);
    } else if (selectedTab == 1) {
      return ForumRepliesComponent();
    } else if (selectedTab == 2) {
      return Offstage();
    } else
      return ForumTopicComponent(isFavTab: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      appBar: AppBar(
        backgroundColor: svGetScaffoldColor(),
        iconTheme: IconThemeData(color: context.iconColor),
        title: Text('Forum', style: boldTextStyle(size: 20)),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: context.cardColor, borderRadius: radius(8)),
              child: AppTextField(
                textFieldType: TextFieldType.NAME,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Here',
                  hintStyle: secondaryTextStyle(color: svGetBodyColor()),
                  prefixIcon: Image.asset('images/tumy/icons/ic_Search.png',
                          height: 16,
                          width: 16,
                          fit: BoxFit.cover,
                          color: svGetBodyColor())
                      .paddingAll(16),
                ),
              ),
            ),
            HorizontalList(
              spacing: 0,
              padding: EdgeInsets.all(16),
              itemCount: tabList.length,
              itemBuilder: (context, index) {
                return AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius(8)),
                  text: tabList[index],
                  textStyle: boldTextStyle(
                      color: selectedTab == index
                          ? Colors.white
                          : svGetBodyColor(),
                      size: 14),
                  onTap: () {
                    selectedTab = index;
                    setState(() {});
                  },
                  elevation: 0,
                  color: selectedTab == index
                      ? AppColorPrimary
                      : svGetScaffoldColor(),
                );
              },
            ),
            getTabContainer(),
          ],
        ),
      ),
    );
  }
}
