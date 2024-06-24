import 'package:cloud_firestore/cloud_firestore.dart';

// User Model
class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final String bio;
  final String avatar;
  final String role;
  final List<String> followers;
  final List<String> following;
  final List<String> messagesSent;
  final List<String> messagesReceived;
  final List<String> notifications;
  final List<String> savedPosts;
  final List<String> payments;
  final List<String> referrals;
  final List<String> referredUsers;
  final List<String> pregnancyProgress;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    this.bio = '',
    this.avatar = '',
    this.role = 'USER',
    this.followers = const [],
    this.following = const [],
    this.messagesSent = const [],
    this.messagesReceived = const [],
    this.notifications = const [],
    this.savedPosts = const [],
    this.payments = const [],
    this.referrals = const [],
    this.referredUsers = const [],
    this.pregnancyProgress = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      name: data['name'] ?? '',
      bio: data['bio'] ?? '',
      avatar: data['avatar'] ?? '',
      role: data['role'] ?? 'USER',
      followers: List<String>.from(data['followers'] ?? []),
      following: List<String>.from(data['following'] ?? []),
      messagesSent: List<String>.from(data['messagesSent'] ?? []),
      messagesReceived: List<String>.from(data['messagesReceived'] ?? []),
      notifications: List<String>.from(data['notifications'] ?? []),
      savedPosts: List<String>.from(data['savedPosts'] ?? []),
      payments: List<String>.from(data['payments'] ?? []),
      referrals: List<String>.from(data['referrals'] ?? []),
      referredUsers: List<String>.from(data['referredUsers'] ?? []),
      pregnancyProgress: List<String>.from(data['pregnancyProgress'] ?? []),
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'bio': bio,
      'avatar': avatar,
      'role': role,
      'followers': followers,
      'following': following,
      'messagesSent': messagesSent,
      'messagesReceived': messagesReceived,
      'notifications': notifications,
      'savedPosts': savedPosts,
      'payments': payments,
      'referrals': referrals,
      'referredUsers': referredUsers,
      'pregnancyProgress': pregnancyProgress,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'bio': bio,
      'avatar': avatar,
      'role': role,
      'followers': followers,
      'following': following,
      'messagesSent': messagesSent,
      'messagesReceived': messagesReceived,
      'notifications': notifications,
      'savedPosts': savedPosts,
      'payments': payments,
      'referrals': referrals,
      'referredUsers': referredUsers,
      'pregnancyProgress': pregnancyProgress,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      avatar: map['avatar'] ?? '',
      role: map['role'] ?? 'USER',
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      messagesSent: List<String>.from(map['messagesSent'] ?? []),
      messagesReceived: List<String>.from(map['messagesReceived'] ?? []),
      notifications: List<String>.from(map['notifications'] ?? []),
      savedPosts: List<String>.from(map['savedPosts'] ?? []),
      payments: List<String>.from(map['payments'] ?? []),
      referrals: List<String>.from(map['referrals'] ?? []),
      referredUsers: List<String>.from(map['referredUsers'] ?? []),
      pregnancyProgress: List<String>.from(map['pregnancyProgress'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

// Post Model
class Post {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final List<String> comments;
  final List<String> likes;
  final List<String> savedBy;
  final List<String> images;
  final List<String> storyImages;
  final String video;
  final List<String> hashtags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    this.comments = const [],
    this.likes = const [],
    this.savedBy = const [],
    this.images = const [],
    this.storyImages = const [],
    this.video = '',
    this.hashtags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      authorId: data['authorId'] ?? '',
      comments: List<String>.from(data['comments'] ?? []),
      likes: List<String>.from(data['likes'] ?? []),
      savedBy: List<String>.from(data['savedBy'] ?? []),
      images: List<String>.from(data['images'] ?? []),
      storyImages: List<String>.from(data['storyImages'] ?? []),
      video: data['video'] ?? '',
      hashtags: List<String>.from(data['hashtags'] ?? []),
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'authorId': authorId,
      'comments': comments,
      'likes': likes,
      'savedBy': savedBy,
      'images': images,
      'storyImages': storyImages,
      'video': video,
      'hashtags': hashtags,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  //toMap() and fromMap() methods
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authorId': authorId,
      'comments': comments,
      'likes': likes,
      'savedBy': savedBy,
      'images': images,
      'storyImages': storyImages,
      'video': video,
      'hashtags': hashtags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      authorId: map['authorId'] ?? '',
      comments: List<String>.from(map['comments'] ?? []),
      likes: List<String>.from(map['likes'] ?? []),
      savedBy: List<String>.from(map['savedBy'] ?? []),
      images: List<String>.from(map['images'] ?? []),
      storyImages: List<String>.from(map['storyImages'] ?? []),
      video: map['video'] ?? '',
      hashtags: List<String>.from(map['hashtags'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

// Comment Model
class Comment {
  final String id;
  final String content;
  final String postId;
  final String authorId;
  final List<String> likes;
  final List<String> replies;
  final String? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.content,
    required this.postId,
    required this.authorId,
    this.likes = const [],
    this.replies = const [],
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id,
      content: data['content'] ?? '',
      postId: data['postId'] ?? '',
      authorId: data['authorId'] ?? '',
      likes: List<String>.from(data['likes'] ?? []),
      replies: List<String>.from(data['replies'] ?? []),
      parentId: data['parentId'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'postId': postId,
      'authorId': authorId,
      'likes': likes,
      'replies': replies,
      'parentId': parentId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'postId': postId,
      'authorId': authorId,
      'likes': likes,
      'replies': replies,
      'parentId': parentId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      postId: map['postId'] ?? '',
      authorId: map['authorId'] ?? '',
      likes: List<String>.from(map['likes'] ?? []),
      replies: List<String>.from(map['replies'] ?? []),
      parentId: map['parentId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

// Like Model
class Like {
  final String id;
  final String userId;
  final String? postId;
  final String? commentId;
  final DateTime createdAt;

  Like({
    required this.id,
    required this.userId,
    this.postId,
    this.commentId,
    required this.createdAt,
  });

  factory Like.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Like(
      id: doc.id,
      userId: data['userId'] ?? '',
      postId: data['postId'],
      commentId: data['commentId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'postId': postId,
      'commentId': commentId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'postId': postId,
      'commentId': commentId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      postId: map['postId'],
      commentId: map['commentId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// Follower Model
class Follower {
  final String id;
  final String followerId;
  final String followingId;
  final DateTime createdAt;

  Follower({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  factory Follower.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Follower(
      id: doc.id,
      followerId: data['followerId'] ?? '',
      followingId: data['followingId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'followerId': followerId,
      'followingId': followingId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'followerId': followerId,
      'followingId': followingId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Follower.fromMap(Map<String, dynamic> map) {
    return Follower(
      id: map['id'] ?? '',
      followerId: map['followerId'] ?? '',
      followingId: map['followingId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// Message Model
class Message {
  final String id;
  final String content;
  final String senderId;
  final String receiverId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      content: data['content'] ?? '',
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'senderId': senderId,
      'receiverId': receiverId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'receiverId': receiverId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// Notification Model
class Notification {
  final String id;
  final String content;
  final String userId;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.content,
    required this.userId,
    required this.createdAt,
  });

  factory Notification.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Notification(
      id: doc.id,
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// Payment Model
class Payment {
  final String id;
  final double amount;
  final String currency;
  final String status;
  final String userId;
  final String stripeId;
  final String description;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.userId,
    required this.stripeId,
    required this.description,
    this.metadata = const {},
    required this.createdAt,
  });

  factory Payment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Payment(
      id: doc.id,
      amount: data['amount'] ?? 0.0,
      currency: data['currency'] ?? '',
      status: data['status'] ?? '',
      userId: data['userId'] ?? '',
      stripeId: data['stripeId'] ?? '',
      description: data['description'] ?? '',
      metadata: data['metadata'] ?? {},
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'amount': amount,
      'currency': currency,
      'status': status,
      'userId': userId,
      'stripeId': stripeId,
      'description': description,
      'metadata': metadata,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'status': status,
      'userId': userId,
      'stripeId': stripeId,
      'description': description,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] ?? '',
      amount: map['amount'] ?? 0.0,
      currency: map['currency'] ?? '',
      status: map['status'] ?? '',
      userId: map['userId'] ?? '',
      stripeId: map['stripeId'] ?? '',
      description: map['description'] ?? '',
      metadata: map['metadata'] ?? {},
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// Affiliate Model
class Affiliate {
  final String id;
  final String userId;
  final String referralCode;
  final double commission;
  final List<String> referredUsers;
  final DateTime createdAt;

  Affiliate({
    required this.id,
    required this.userId,
    required this.referralCode,
    required this.commission,
    this.referredUsers = const [],
    required this.createdAt,
  });

  factory Affiliate.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Affiliate(
      id: doc.id,
      userId: data['userId'] ?? '',
      referralCode: data['referralCode'] ?? '',
      commission: data['commission'] ?? 0.0,
      referredUsers: List<String>.from(data['referredUsers'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'referralCode': referralCode,
      'commission': commission,
      'referredUsers': referredUsers,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'referralCode': referralCode,
      'commission': commission,
      'referredUsers': referredUsers,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Affiliate.fromMap(Map<String, dynamic> map) {
    return Affiliate(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      referralCode: map['referralCode'] ?? '',
      commission: map['commission'] ?? 0.0,
      referredUsers: List<String>.from(map['referredUsers'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// SavedPost Model
class SavedPost {
  final String id;
  final String userId;
  final String postId;
  final String category;
  final DateTime createdAt;

  SavedPost({
    required this.id,
    required this.userId,
    required this.postId,
    required this.category,
    required this.createdAt,
  });

  factory SavedPost.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return SavedPost(
      id: doc.id,
      userId: data['userId'] ?? '',
      postId: data['postId'] ?? '',
      category: data['category'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'postId': postId,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'postId': postId,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SavedPost.fromMap(Map<String, dynamic> map) {
    return SavedPost(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      postId: map['postId'] ?? '',
      category: map['category'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// PregnancyProgress Model
class PregnancyProgress {
  final String id;
  final String userId;
  final int week;
  final String details;
  final DateTime createdAt;

  PregnancyProgress({
    required this.id,
    required this.userId,
    required this.week,
    required this.details,
    required this.createdAt,
  });

  factory PregnancyProgress.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PregnancyProgress(
      id: doc.id,
      userId: data['userId'] ?? '',
      week: data['week'] ?? 0,
      details: data['details'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'week': week,
      'details': details,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'week': week,
      'details': details,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PregnancyProgress.fromMap(Map<String, dynamic> map) {
    return PregnancyProgress(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      week: map['week'] ?? 0,
      details: map['details'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// Image Model
class Image {
  final String id;
  final String url;
  final String postId;
  final DateTime createdAt;

  Image({
    required this.id,
    required this.url,
    required this.postId,
    required this.createdAt,
  });

  factory Image.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Image(
      id: doc.id,
      url: data['url'] ?? '',
      postId: data['postId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'url': url,
      'postId': postId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'postId': postId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      id: map['id'] ?? '',
      url: map['url'] ?? '',
      postId: map['postId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

// Hashtag Model
class Hashtag {
  final String id;
  final String tag;
  final List<String> posts;

  Hashtag({
    required this.id,
    required this.tag,
    this.posts = const [],
  });

  factory Hashtag.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Hashtag(
      id: doc.id,
      tag: data['tag'] ?? '',
      posts: List<String>.from(data['posts'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'tag': tag,
      'posts': posts,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag,
      'posts': posts,
    };
  }

  factory Hashtag.fromMap(Map<String, dynamic> map) {
    return Hashtag(
      id: map['id'] ?? '',
      tag: map['tag'] ?? '',
      posts: List<String>.from(map['posts'] ?? []),
    );
  }
}
