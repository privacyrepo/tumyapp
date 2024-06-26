import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/firebase/models/FirestoreService.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image;
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';
import 'CommentReplyComponent.dart';

class CommentComponent extends StatefulWidget {
  final Comment comment;
  final Function(String?) onReply;
  final bool isReplying;

  CommentComponent({
    required this.comment,
    required this.onReply,
    required this.isReplying,
  });

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  final FirestoreService _firestoreService = FirestoreService();
  User? currentUser;
  User? authorUser;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<AuthProvider>(context, listen: false).currentUser;
    isLiked = widget.comment.likes.contains(currentUser?.id);
    _fetchAuthorInfo();
  }

  Future<void> _fetchAuthorInfo() async {
    DocumentSnapshot userDoc =
        await _firestoreService.getUserById(widget.comment.authorId);
    setState(() {
      authorUser = User.fromFirestore(userDoc);
    });
  }

  void _toggleLike() {
    if (currentUser == null) return;

    setState(() {
      if (isLiked) {
        widget.comment.likes.remove(currentUser!.id);
      } else {
        widget.comment.likes.add(currentUser!.id);
      }
      isLiked = !isLiked;
    });
    _firestoreService.updateComment(
        widget.comment.id, widget.comment.toFirestore());
  }

  @override
  Widget build(BuildContext context) {
    return authorUser == null
        ? CircularProgressIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (authorUser!.avatar.isNotEmpty)
                        Image.network(
                          authorUser!.avatar,
                          height: 48,
                          width: 48,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Icon(Icons.error,
                                size: 48); // Error icon or any other placeholder
                          },
                        ).cornerRadiusWithClipRRect(8)
                      else
                        Icon(Icons.person, size: 48).cornerRadiusWithClipRRect(8),
                      16.width,
                      Text(authorUser!.name.validate(),
                          style: boldTextStyle(size: 14)),
                      4.width,
                      Image.asset('images/tumy/icons/ic_TickSquare.png',
                          height: 14, width: 14, fit: BoxFit.cover),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'images/tumy/icons/ic_TimeSquare.png',
                        height: 14,
                        width: 14,
                        fit: BoxFit.cover,
                        color: context.iconColor,
                      ),
                      4.width,
                      Text(timeAgo(widget.comment.createdAt),
                          style: secondaryTextStyle(
                              color: svGetBodyColor(), size: 12)),
                    ],
                  ),
                ],
              ),
              16.height,
              Text(widget.comment.content.validate(),
                  style: secondaryTextStyle(color: svGetBodyColor())),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _toggleLike,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: radius(4),
                        color: svGetScaffoldColor(),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isLiked
                              ? Image.asset(
                                  'images/tumy/icons/ic_HeartFilled.png',
                                  height: 14,
                                  width: 14,
                                  fit: BoxFit.fill)
                              : Image.asset(
                                  'images/tumy/icons/ic_Heart.png',
                                  height: 14,
                                  width: 14,
                                  fit: BoxFit.cover,
                                  color: svGetBodyColor(),
                                ),
                          2.width,
                          Text(widget.comment.likes.length.toString(),
                              style: secondaryTextStyle(size: 12)),
                        ],
                      ),
                    ),
                  ),
                  16.width,
                  GestureDetector(
                    onTap: () {
                      widget.onReply(widget.comment.id);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: radius(4),
                        color: svGetScaffoldColor(),
                      ),
                      child: Text('Reply', style: secondaryTextStyle(size: 12)),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(
            top: 16,
            left: widget.comment.parentId != '' ? 70 : 16,
            right: 16,
            bottom: 16,
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
