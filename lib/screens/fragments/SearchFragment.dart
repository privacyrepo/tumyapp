import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/models/SearchModel.dart';
import 'package:tumy_app/screens/fragments/ProfileFragment.dart';
import 'package:tumy_app/screens/search/components/SearchCardComponent.dart';
import 'package:tumy_app/utils/Common.dart';

class SearchFragment extends StatefulWidget {
  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  List<SearchModel> list = [];

  @override
  void initState() {
    list = getRecentList();
    super.initState();
    afterBuildCreated(() {
      setStatusBarColor(svGetScaffoldColor());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: svGetScaffoldColor(),
      appBar: AppBar(
        backgroundColor: svGetScaffoldColor(),
        iconTheme: IconThemeData(color: context.iconColor),
        leadingWidth: 30,
        title: Container(
          decoration:
              BoxDecoration(color: context.cardColor, borderRadius: radius(8)),
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RECENT', style: boldTextStyle()).paddingAll(16),
            ListView.separated(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SearchCardComponent(element: list[index]).onTap(() {
                  ProfileFragment().launch(context);
                });
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 20);
              },
              itemCount: list.length,
            ),
          ],
        ),
      ),
    );
  }
}
