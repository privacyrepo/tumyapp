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
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String? activeCommentId; // ID of the comment being replied to

  void _setActiveComment(String? commentId) {
    setState(() {
      activeCommentId = commentId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Stack(
        children: [
          StreamBuilder<List<Comment>>(
            stream: _firestoreService.getComments(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<Comment> commentList = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: commentList.map((comment) {
                    return Column(
                      children: [
                        CommentComponent(
                          comment: comment,
                          onReply: _setActiveComment,
                          isReplying: activeCommentId == comment.id,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
          if (activeCommentId == null)
            CommentReplyComponent(
              parentId: '',
              onSubmitted: () => _setActiveComment(null),
            ),
        ],
      ),
    );
  }
}
