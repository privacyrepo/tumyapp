import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Constants.dart';

class ProfilePostsComponent extends StatefulWidget {
  const ProfilePostsComponent({Key? key}) : super(key: key);

  @override
  State<ProfilePostsComponent> createState() => _ProfilePostsComponentState();
}

class _ProfilePostsComponentState extends State<ProfilePostsComponent> {
  int selectedIndex = 0;

  List<String> allPostList = [
    'images/tumy/posts/post_one.png',
    'images/tumy/posts/post_two.png',
    'images/tumy/posts/post_three.png',
    'images/tumy/posts/post_one.png',
    'images/tumy/posts/post_two.png',
    'images/tumy/posts/post_three.png',
    'images/tumy/posts/post_one.png',
    'images/tumy/posts/post_two.png',
    'images/tumy/posts/post_three.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: context.cardColor, borderRadius: radius(AppContainerRadius)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      selectedIndex = 0;
                      setState(() {});
                    },
                    child: Text(
                      'All Post',
                      style: TextStyle(
                        color: AppColorPrimary,
                        fontSize: 14,
                        fontWeight: selectedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: context.width() / 2 - 32,
                    color: selectedIndex == 0
                        ? AppColorPrimary
                        : AppColorPrimary.withOpacity(0.5),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      selectedIndex = 1;
                      setState(() {});
                    },
                    child: Text(
                      'Mentions',
                      style: TextStyle(
                        color: AppColorPrimary,
                        fontSize: 14,
                        fontWeight: selectedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: context.width() / 2 - 32,
                    color: selectedIndex == 1
                        ? AppColorPrimary
                        : AppColorPrimary.withOpacity(0.5),
                  ),
                ],
              ),
              16.height,
            ],
          ),
          16.height,
          GridView.builder(
            itemCount: allPostList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(allPostList[index],
                      height: 100, fit: BoxFit.cover)
                  .cornerRadiusWithClipRRect(8);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
          ),
        ],
      ),
    );
  }
}
