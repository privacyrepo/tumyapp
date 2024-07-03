import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image;
import 'package:tumy_app/firebase/models/FirestoreService.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';
import 'package:uuid/uuid.dart';
class CommentReplyComponent extends StatefulWidget {
  final String postId;
  final String parentId; // Pass the parent comment ID if it's a reply
  final VoidCallback onSubmitted;
  final FocusNode focusNode; // Add FocusNode

  const CommentReplyComponent({
    Key? key,
    required this.postId,
    required this.parentId,
    required this.onSubmitted,
    required this.focusNode, // Add FocusNode to constructor
  }) : super(key: key);

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
    final Uuid uuid = Uuid();
    Comment newComment = Comment(
      id: uuid.v4(), // Firestore will generate an ID
      content: _commentController.text.trim(),
      postId: widget.postId, // Set the postId accordingly if this is related to a post
      authorId: currentUser.id,
      likes: [],
      replies: [],
      parentId: widget.parentId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _firestoreService.addCommentAndUpdatePost(newComment);
    _commentController.clear();
    widget.onSubmitted(); // Call the callback to reset the active comment
  }

  @override
  void didUpdateWidget(CommentReplyComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode.hasFocus) {
      widget.focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUser = authProvider.currentUser;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: svGetScaffoldColor(),
      child: Row(
        children: [
          currentUser == null || currentUser.avatar.isEmpty
              ? Icon(Icons.person, size: 48) // Placeholder icon
              : Image.network(
                  currentUser.avatar,
                  height: 48,
                  width: 48,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Icon(Icons.error, size: 48); // Error icon or any other placeholder
                  },
                ).cornerRadiusWithClipRRect(8),
          10.width,
          Expanded(
            child: AppTextField(
              controller: _commentController,
              focus: widget.focusNode, // Set the FocusNode
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
    );
  }
}
