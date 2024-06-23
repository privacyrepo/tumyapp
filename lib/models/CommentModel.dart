class CommentModel {
  String? name;
  String? profileImage;
  String? time;
  String? comment;
  int? likeCount;
  bool? isCommentReply;
  bool? like;

  CommentModel(
      {this.name,
      this.profileImage,
      this.time,
      this.comment,
      this.likeCount,
      this.isCommentReply,
      this.like});
}

List<CommentModel> getComments() {
  List<CommentModel> list = [];

  list.add(CommentModel(
    name: 'Iana',
    profileImage: 'images/tumy/faces/face_1.png',
    time: '4m',
    likeCount: 4,
    comment:
        'Loving😍 your work and profile👨. Top Marks. Once you are confident enough to develop @ira_membrit',
    isCommentReply: false,
    like: false,
  ));
  list.add(CommentModel(
    name: 'Allie',
    profileImage: 'images/tumy/faces/face_2.png',
    time: '4m',
    likeCount: 4,
    comment: 'Nice 👌Work, love your content',
    isCommentReply: false,
    like: false,
  ));
  list.add(CommentModel(
    name: 'Manny',
    profileImage: 'images/tumy/faces/face_3.png',
    time: '4m',
    likeCount: 4,
    comment: 'Thanks 🤟@wad-warren. Follow us for more update',
    isCommentReply: true,
    like: false,
  ));
  list.add(CommentModel(
    name: 'Isabelle',
    profileImage: 'images/tumy/faces/face_4.png',
    time: '4m',
    likeCount: 4,
    comment: 'Really Cool 👍 which filter are you using 🎞@con_trariweis',
    isCommentReply: true,
    like: false,
  ));
  list.add(CommentModel(
    name: 'Jenny Wilson',
    profileImage: 'images/tumy/faces/face_5.png',
    time: '4m',
    likeCount: 4,
    comment:
        'Hey Guys✋, I recommend you to try this smart pluginfor design System @Jane_Cooper',
    isCommentReply: false,
    like: false,
  ));
  list.add(CommentModel(
    name: 'Iana',
    profileImage: 'images/tumy/faces/face_1.png',
    time: '4m',
    likeCount: 4,
    comment: 'Great,that awesome work @Jane_Cooper.',
    isCommentReply: false,
    like: false,
  ));

  return list;
}
