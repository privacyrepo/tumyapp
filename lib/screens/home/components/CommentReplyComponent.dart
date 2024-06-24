import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image;
import 'package:tumy_app/firebase/models/FirestoreService.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';

class CommentReplyComponent extends StatefulWidget {
  final String parentId; // Pass the parent comment ID if it's a reply
  final VoidCallback onSubmitted;

  const CommentReplyComponent(
      {Key? key, required this.parentId, required this.onSubmitted})
      : super(key: key);

  @override
  _CommentReplyComponentState createState() => _CommentReplyComponentState();
}

class _CommentReplyComponentState extends State<CommentReplyComponent> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _commentController = TextEditingController();

  void _addComment() async {
    if (_commentController.text.trim().isEmpty) {
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      // Handle user not being logged in
      return;
    }

    Comment newComment = Comment(
      id: '', // Firestore will generate an ID
      content: _commentController.text.trim(),
      postId: '', // Set the postId accordingly if this is related to a post
      authorId: currentUser.id,
      likes: [],
      replies: [],
      parentId: widget.parentId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _firestoreService.createComment(newComment);
    _commentController.clear();
    widget.onSubmitted(); // Call the callback to reset the active comment
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUser;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      color: svGetScaffoldColor(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              16.width,
              currentUser == null
                  ? CircularProgressIndicator()
                  : Image.network(
                      currentUser.avatar,
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(8),
              10.width,
              Expanded(
                child: AppTextField(
                  controller: _commentController,
                  textFieldType: TextFieldType.OTHER,
                  decoration: InputDecoration(
                    hintText: 'Write A Comment',
                    hintStyle: secondaryTextStyle(color: svGetBodyColor()),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              TextButton(
                onPressed: _addComment,
                child: Text(
                  'Reply',
                  style: secondaryTextStyle(color: AppColorPrimary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
