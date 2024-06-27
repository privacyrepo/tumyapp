import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'FirestoreModels.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> addDummyData(int userCount, int postCount, int commentCount) async {
  await clearExistingData();
  await addUsers(userCount);
  await addPosts(postCount);
  await addComments(commentCount);
}

Future<void> clearExistingData() async {
  WriteBatch batch = firestore.batch();

  // Clear users
  QuerySnapshot userSnapshot = await firestore.collection('users').get();
  for (QueryDocumentSnapshot doc in userSnapshot.docs) {
    batch.delete(doc.reference);
  }

  // Clear posts
  QuerySnapshot postSnapshot = await firestore.collection('posts').get();
  for (QueryDocumentSnapshot doc in postSnapshot.docs) {
    batch.delete(doc.reference);
  }

  // Clear comments
  QuerySnapshot commentSnapshot = await firestore.collection('comments').get();
  for (QueryDocumentSnapshot doc in commentSnapshot.docs) {
    batch.delete(doc.reference);
  }

  await batch.commit();
  print('Existing data cleared.');
}

Future<void> addUsers(int count) async {
  WriteBatch batch = firestore.batch();
  for (int i = 0; i < count; i++) {
    String userId = uuid.v4();
    User user = User(
      id: userId,
      email: 'user${i}@example.com',
      password: 'password${i}',
      name: 'User ${i}',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    batch.set(firestore.collection('users').doc(userId), user.toFirestore());
  }
  await batch.commit();
  print('$count users added.');
}

Future<void> addPosts(int count) async {
  QuerySnapshot userSnapshot = await firestore.collection('users').get();
  List<String> userIds = userSnapshot.docs.map((doc) => doc.id).toList();

  WriteBatch batch = firestore.batch();
  for (int i = 0; i < count; i++) {
    String postId = uuid.v4();
    String authorId = userIds[i % userIds.length];
    Post post = Post(
      id: postId,
      title: 'Post Title ${i}',
      description: 'Post Description ${i}',
      authorId: authorId,
      images: ['https://picsum.photos/200/300','https://picsum.photos/200/300','https://picsum.photos/200/300'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    batch.set(firestore.collection('posts').doc(postId), post.toFirestore());
  }
  await batch.commit();
  print('$count posts added.');
}

Future<void> addComments(int count) async {
  QuerySnapshot postSnapshot = await firestore.collection('posts').get();
  List<String> postIds = postSnapshot.docs.map((doc) => doc.id).toList();

  QuerySnapshot userSnapshot = await firestore.collection('users').get();
  List<String> userIds = userSnapshot.docs.map((doc) => doc.id).toList();

  QuerySnapshot commentSnapshot = await firestore.collection('comments').get();
  List<String> existingCommentIds = commentSnapshot.docs.map((doc) => doc.id).toList();

  WriteBatch batch = firestore.batch();
  for (int i = 0; i < count; i++) {
    String commentId = uuid.v4();
    String postId = postIds[i % postIds.length];
    String authorId = userIds[i % userIds.length];
    String? parentId;
    
    // 30% chance that this comment is a sub-comment
    if (existingCommentIds.isNotEmpty && i % 10 < 3) {
      parentId = existingCommentIds[i % existingCommentIds.length];
    }

    Comment comment = Comment(
      id: commentId,
      content: 'Comment content ${i}',
      postId: postId,
      authorId: authorId,
      parentId: parentId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    batch.set(firestore.collection('comments').doc(commentId), comment.toFirestore());

    // Update the post with the new comment ID
    DocumentReference postRef = firestore.collection('posts').doc(postId);
    batch.update(postRef, {
      'comments': FieldValue.arrayUnion([commentId])
    });

    if (parentId != null) {
      // Update the parent comment with the new reply ID
      DocumentReference parentCommentRef = firestore.collection('comments').doc(parentId);
      batch.update(parentCommentRef, {
        'replies': FieldValue.arrayUnion([commentId])
      });
    }

    existingCommentIds.add(commentId); // Add new commentId to the list
  }
  await batch.commit();
  print('$count comments added.');
}

