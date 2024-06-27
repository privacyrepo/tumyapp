import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/screens/home/screens/CommentScreen.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' as firestore_models; // Add this line

class PostComponent extends StatefulWidget {
  final List<firestore_models.Post> postList; // Pass a list of Post objects

  PostComponent({required this.postList});

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.postList.length,
      itemBuilder: (context, index) {
        firestore_models.Post post = widget.postList[index];

        return Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: radius(AppCommonRadius), color: context.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Assuming profile image is the first image in images list
                      post.images.isNotEmpty
                          ? Image.network(
                              post.images[0],
                              height: 56,
                              width: 56,
                              fit: BoxFit.cover,
                            ).cornerRadiusWithClipRRect(AppCommonRadius)
                          : Icon(Icons.person, size: 56), // Placeholder icon
                      12.width,
                      Text(post.title.validate(), style: boldTextStyle()),
                      4.width,
                      Image.asset('images/tumy/icons/ic_TickSquare.png',
                          height: 14, width: 14, fit: BoxFit.cover),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  Row(
                    children: [
                      Text(timeAgo(post.createdAt),
                          style: secondaryTextStyle(
                              color: svGetBodyColor(), size: 12)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.more_horiz)),
                    ],
                  ).paddingSymmetric(horizontal: 8),
                ],
              ),
              16.height,
              post.description.validate().isNotEmpty
                  ? svRobotoText(
                          text: post.description.validate(),
                          textAlign: TextAlign.start)
                      .paddingSymmetric(horizontal: 16)
                  : Offstage(),
              post.description.validate().isNotEmpty
                  ? 16.height
                  : Offstage(),
              post.images.isNotEmpty
                  ? Image.network(
                      post.images[0], // Assuming the first image is the post image
                      height: 300,
                      width: context.width() - 32,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(AppCommonRadius).center()
                  : Offstage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/tumy/icons/ic_Chat.png',
                        height: 22,
                        width: 22,
                        fit: BoxFit.cover,
                        color: context.iconColor,
                      ).onTap(() {
                        CommentScreen(postId: post.id,).launch(context);
                      },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent),
                      IconButton(
                        icon: post.likes.contains('currentUserId') // Check if the current user liked the post
                            ? Image.asset(
                                'images/tumy/icons/ic_HeartFilled.png',
                                height: 20,
                                width: 22,
                                fit: BoxFit.fill)
                            : Image.asset(
                                'images/tumy/icons/ic_Heart.png',
                                height: 22,
                                width: 22,
                                fit: BoxFit.cover,
                                color: context.iconColor,
                              ),
                        onPressed: () {
                          setState(() {
                            if (post.likes.contains('currentUserId')) {
                              post.likes.remove('currentUserId');
                            } else {
                              post.likes.add('currentUserId');
                            }
                          });
                        },
                      ),
                      Image.asset(
                        'images/tumy/icons/ic_Send.png',
                        height: 22,
                        width: 22,
                        fit: BoxFit.cover,
                        color: context.iconColor,
                      ).onTap(() {
                        svShowShareBottomSheet(context);
                      },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent),
                    ],
                  ),
                  Text('${post.comments.length} comments',
                      style: secondaryTextStyle(color: svGetBodyColor())),
                ],
              ).paddingSymmetric(horizontal: 16),
              Divider(indent: 16, endIndent: 16, height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 56,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: radius(100)),
                            child: Image.asset('images/tumy/faces/face_1.png',
                                    height: 24, width: 24, fit: BoxFit.cover)
                                .cornerRadiusWithClipRRect(100),
                          ),
                          right: 0,
                        ),
                        Positioned(
                          left: 14,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: radius(100)),
                            child: Image.asset('images/tumy/faces/face_2.png',
                                    height: 24, width: 24, fit: BoxFit.cover)
                                .cornerRadiusWithClipRRect(100),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: radius(100)),
                            child: Image.asset('images/tumy/faces/face_3.png',
                                    height: 24, width: 24, fit: BoxFit.cover)
                                .cornerRadiusWithClipRRect(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.width,
                  RichText(
                    text: TextSpan(
                      text: 'Liked By ',
                      style:
                          secondaryTextStyle(color: svGetBodyColor(), size: 12),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Ms.Mountain ',
                            style: boldTextStyle(size: 12)),
                        TextSpan(
                            text: 'And ',
                            style: secondaryTextStyle(
                                color: svGetBodyColor(), size: 12)),
                        TextSpan(
                            text: '1,10 Others ',
                            style: boldTextStyle(size: 12)),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  String timeAgo(DateTime date) {
    Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 8) {
      return '${difference.inDays ~/ 7} weeks';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '${(difference.inDays / 7).floor()} week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days';
    } else if (difference.inDays >= 1) {
      return '1 day';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours';
    } else if (difference.inHours >= 1) {
      return '1 hour';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes';
    } else if (difference.inMinutes >= 1) {
      return '1 minute';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds';
    } else {
      return 'just now';
    }
  }
}
