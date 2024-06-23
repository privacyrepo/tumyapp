import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class PostOptionsComponent extends StatefulWidget {
  @override
  State<PostOptionsComponent> createState() => _PostOptionsComponentState();
}

class _PostOptionsComponentState extends State<PostOptionsComponent> {
  List<String> list = [
    'images/tumy/posts/post_one.png',
    'images/tumy/posts/post_two.png',
    'images/tumy/posts/post_three.png',
    'images/tumy/postImage.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: svGetScaffoldColor(),
        borderRadius: radiusOnly(
            topRight: AppContainerRadius, topLeft: AppContainerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 62,
                  width: 52,
                  color: context.cardColor,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Image.asset('images/tumy/icons/ic_CameraPost.png',
                      height: 22, width: 22, fit: BoxFit.cover),
                ),
                HorizontalList(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Image.asset(list[index],
                        height: 62, width: 52, fit: BoxFit.cover);
                  },
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('images/tumy/icons/ic_Video.png',
                  height: 32, width: 32, fit: BoxFit.cover),
              //Image.asset('images/tumy/icons/ic_CameraPost.png', height: 32, width: 32, fit: BoxFit.cover),
              Image.asset('images/tumy/icons/ic_Voice.png',
                  height: 32, width: 32, fit: BoxFit.cover),
              Image.asset('images/tumy/icons/ic_Location.png',
                  height: 32, width: 32, fit: BoxFit.cover),
              Image.asset('images/tumy/icons/ic_Paper.png',
                  height: 32, width: 32, fit: BoxFit.cover),
            ],
          ),
        ],
      ),
    );
  }
}
