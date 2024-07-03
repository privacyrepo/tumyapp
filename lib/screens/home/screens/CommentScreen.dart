import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/firebase/models/FirestoreService.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image;
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/screens/home/components/CommentComponent.dart';
import 'package:tumy_app/screens/home/components/CommentReplyComponent.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  CommentScreen({required this.postId});

  static void launch(BuildContext context, String postId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CommentScreen(postId: postId),
      ),
    );
  }

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String? activeCommentId; // ID of the comment being replied to
  final FocusNode _focusNode = FocusNode(); // Add FocusNode

  void _setActiveComment(String? commentId) {
    setState(() {
      activeCommentId = commentId;
    });
    if (commentId != null) {
      _focusNode.requestFocus(); // Request focus when a comment is selected
    }
  }

  List<Comment> _sortComments(List<Comment> comments) {
    comments.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort by time, latest on top
    return comments;
  }

  List<Widget> _buildCommentTree(List<Comment> comments, String? parentId) {
    List<Widget> commentTree = [];
    List<Comment> sortedComments = _sortComments(comments);

    for (var comment in sortedComments.where((c) =>
       c.parentId == parentId || 
      (c.parentId == '' && parentId == null) || 
      (c.parentId == null && parentId == '') || 
      (c.parentId == null && parentId == null) || 
      (c.parentId == '' && parentId == '')))  {
      commentTree.add(CommentComponent(
        comment: comment,
        onReply: _setActiveComment,
        isReplying: activeCommentId == comment.id,
      ));
      commentTree.addAll(_buildCommentTree(sortedComments, comment.id)); // Recursively add child comments
    }

    return commentTree;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus(); // Unfocus when tapping outside
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Comment>>(
                stream: _firestoreService.getCommentsByPostId(widget.postId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Comment> commentList = snapshot.data!;
                  List<Widget> commentTree = _buildCommentTree(commentList, null);

                  return SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 80), // Avoid overlap with input box
                    child: Column(
                      children: commentTree,
                    ),
                  );
                },
              ),
            ),
            CommentReplyComponent(
              postId: widget.postId,
              parentId: activeCommentId ?? '',
              onSubmitted: () => _setActiveComment(null),
              focusNode: _focusNode, // Pass the FocusNode
            ),
          ],
        ),
      ),
    );
  }
}
