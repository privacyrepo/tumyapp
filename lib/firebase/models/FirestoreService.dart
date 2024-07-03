import 'package:cloud_firestore/cloud_firestore.dart';
import 'FirestoreModels.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User methods
  Future<void> createUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toFirestore());
  }

  Future<User?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.exists ? User.fromFirestore(doc) : null;
  }

  Future<DocumentSnapshot> getUserById(String userId) {
    return _firestore.collection('users').doc(userId).get();
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(userId).update(data);
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  Stream<User> streamUser(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => User.fromFirestore(doc));
  }

  // Post methods
  Future<String> createPost(Post post) async {
    final docRef = await _firestore.collection('posts').add(post.toFirestore());
    return docRef.id;
  }

  Future<Post?> getPost(String postId) async {
    final doc = await _firestore.collection('posts').doc(postId).get();
    return doc.exists ? Post.fromFirestore(doc) : null;
  }

  Future<void> updatePost(String postId, Map<String, dynamic> data) async {
    await _firestore.collection('posts').doc(postId).update(data);
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  Stream<List<Post>> streamUserPosts(String userId) {
    return _firestore
        .collection('posts')
        .where('authorId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
  }

  // Comment methods
  Future<String> createComment(Comment comment) async {
    final docRef =
        await _firestore.collection('comments').add(comment.toFirestore());
    return docRef.id;
  }

  Future<Comment?> getComment(String commentId) async {
    final doc = await _firestore.collection('comments').doc(commentId).get();
    return doc.exists ? Comment.fromFirestore(doc) : null;
  }

  Stream<List<Comment>> getComments() {
    return _firestore.collection('comments').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Comment.fromFirestore(doc);
      }).toList();
    });
  }
  Future<void> addCommentAndUpdatePost(Comment comment) async {
    WriteBatch batch = _firestore.batch();

    // Reference to the new comment document
    DocumentReference commentRef = _firestore.collection('comments').doc(comment.id);

    // Reference to the post document
    DocumentReference postRef = _firestore.collection('posts').doc(comment.postId);

    // Add the comment
    batch.set(commentRef, comment.toFirestore());

    // Update the post's comments array and count
    batch.update(postRef, {
      'comments': FieldValue.arrayUnion([comment.id]),
    });

    // If the comment is a reply, update the parent comment's replies array
    if (comment.parentId!.isNotEmpty) {
      DocumentReference parentCommentRef = _firestore.collection('comments').doc(comment.parentId);
      batch.update(parentCommentRef, {
        'replies': FieldValue.arrayUnion([comment.id]),
      });
    }

    // Commit the batch
    await batch.commit();
  }
  Stream<List<Comment>> getCommentsByPostId(String postId) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList());
  }

  Future<void> updateComment(
      String commentId, Map<String, dynamic> data) async {
    await _firestore.collection('comments').doc(commentId).update(data);
  }

  Future<void> deleteComment(String commentId) async {
    await _firestore.collection('comments').doc(commentId).delete();
  }

  Stream<List<Comment>> streamPostComments(String postId) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList());
  }

  // Like methods
  Future<String> createLike(Like like) async {
    final docRef = await _firestore.collection('likes').add(like.toFirestore());
    return docRef.id;
  }

  Future<void> deleteLike(String likeId) async {
    await _firestore.collection('likes').doc(likeId).delete();
  }

  Future<bool> checkIfUserLikedPost(String userId, String postId) async {
    final querySnapshot = await _firestore
        .collection('likes')
        .where('userId', isEqualTo: userId)
        .where('postId', isEqualTo: postId)
        .limit(1)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Follower methods
  Future<String> createFollower(Follower follower) async {
    final docRef =
        await _firestore.collection('followers').add(follower.toFirestore());
    return docRef.id;
  }

  Future<void> deleteFollower(String followerId) async {
    await _firestore.collection('followers').doc(followerId).delete();
  }

  Future<bool> checkIfUserFollows(String followerId, String followingId) async {
    final querySnapshot = await _firestore
        .collection('followers')
        .where('followerId', isEqualTo: followerId)
        .where('followingId', isEqualTo: followingId)
        .limit(1)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Stream<List<User>> streamUserFollowers(String userId) {
    return _firestore
        .collection('followers')
        .where('followingId', isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) async {
      List<User> followers = [];
      for (var doc in snapshot.docs) {
        final follower = Follower.fromFirestore(doc);
        final user = await getUser(follower.followerId);
        if (user != null) followers.add(user);
      }
      return followers;
    });
  }

  // Message methods
  Future<String> createMessage(Message message) async {
    final docRef =
        await _firestore.collection('messages').add(message.toFirestore());
    return docRef.id;
  }

  Stream<List<Message>> streamUserMessages(String userId) {
    return _firestore
        .collection('messages')
        .where('receiverId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
  }

  // Notification methods
  Future<String> createNotification(Notification notification) async {
    final docRef = await _firestore
        .collection('notifications')
        .add(notification.toFirestore());
    return docRef.id;
  }

  Stream<List<Notification>> streamUserNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Notification.fromFirestore(doc))
            .toList());
  }

  // Payment methods
  Future<String> createPayment(Payment payment) async {
    final docRef =
        await _firestore.collection('payments').add(payment.toFirestore());
    return docRef.id;
  }

  Future<List<Payment>> getUserPayments(String userId) async {
    final querySnapshot = await _firestore
        .collection('payments')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs.map((doc) => Payment.fromFirestore(doc)).toList();
  }

  // Affiliate methods
  Future<String> createAffiliate(Affiliate affiliate) async {
    final docRef =
        await _firestore.collection('affiliates').add(affiliate.toFirestore());
    return docRef.id;
  }

  Future<Affiliate?> getAffiliateByUserId(String userId) async {
    final querySnapshot = await _firestore
        .collection('affiliates')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    return querySnapshot.docs.isNotEmpty
        ? Affiliate.fromFirestore(querySnapshot.docs.first)
        : null;
  }

  // SavedPost methods
  Future<String> createSavedPost(SavedPost savedPost) async {
    final docRef =
        await _firestore.collection('savedPosts').add(savedPost.toFirestore());
    return docRef.id;
  }

  Future<void> deleteSavedPost(String savedPostId) async {
    await _firestore.collection('savedPosts').doc(savedPostId).delete();
  }

  Stream<List<SavedPost>> streamUserSavedPosts(String userId) {
    return _firestore
        .collection('savedPosts')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => SavedPost.fromFirestore(doc)).toList());
  }

  // PregnancyProgress methods
  Future<String> createPregnancyProgress(PregnancyProgress progress) async {
    final docRef = await _firestore
        .collection('pregnancyProgress')
        .add(progress.toFirestore());
    return docRef.id;
  }

  Stream<List<PregnancyProgress>> streamUserPregnancyProgress(String userId) {
    return _firestore
        .collection('pregnancyProgress')
        .where('userId', isEqualTo: userId)
        .orderBy('week')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PregnancyProgress.fromFirestore(doc))
            .toList());
  }

  // Image methods
  Future<String> createImage(Image image) async {
    final docRef =
        await _firestore.collection('images').add(image.toFirestore());
    return docRef.id;
  }

  Future<List<Image>> getPostImages(String postId) async {
    final querySnapshot = await _firestore
        .collection('images')
        .where('postId', isEqualTo: postId)
        .get();
    return querySnapshot.docs.map((doc) => Image.fromFirestore(doc)).toList();
  }

  // Hashtag methods
  Future<String> createHashtag(Hashtag hashtag) async {
    final docRef =
        await _firestore.collection('hashtags').add(hashtag.toFirestore());
    return docRef.id;
  }

  Future<void> addPostToHashtag(String hashtagId, String postId) async {
    await _firestore.collection('hashtags').doc(hashtagId).update({
      'posts': FieldValue.arrayUnion([postId])
    });
  }

  Future<List<Post>> getPostsByHashtag(String tag) async {
    final hashtagQuery = await _firestore
        .collection('hashtags')
        .where('tag', isEqualTo: tag)
        .limit(1)
        .get();

    if (hashtagQuery.docs.isEmpty) return [];

    final hashtag = Hashtag.fromFirestore(hashtagQuery.docs.first);
    final postsQuery = await _firestore
        .collection('posts')
        .where(FieldPath.documentId, whereIn: hashtag.posts)
        .get();

    return postsQuery.docs.map((doc) => Post.fromFirestore(doc)).toList();
  }


}
