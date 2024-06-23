class PostModel {
  String? name;
  String? profileImage;
  String? postImage;
  String? time;
  String? description;
  int? commentCount;
  bool? like;

  PostModel(
      {this.name,
      this.profileImage,
      this.postImage,
      this.time,
      this.description,
      this.commentCount,
      this.like});
}

List<PostModel> getPosts() {
  List<PostModel> list = [];

  list.add(
    PostModel(
      name: 'Manny',
      profileImage: 'images/tumy/faces/face_3.png',
      time: '4m',
      postImage: 'images/tumy/postImage.png',
      description:
          'The great thing about reaching the top of the mountain is realising that there’s space for more than one person.',
      commentCount: 0,
      like: false,
    ),
  );
  list.add(
    PostModel(
      name: 'Isabelle',
      profileImage: 'images/tumy/faces/face_4.png',
      time: '4m',
      postImage: 'images/tumy/postImage.png',
      commentCount: 0,
      like: false,
    ),
  );
  list.add(
    PostModel(
      name: 'Jenny Wilson',
      profileImage: 'images/tumy/faces/face_5.png',
      time: '4m',
      postImage: 'images/tumy/postImage.png',
      description: 'Making memories that last a lifetime ',
      commentCount: 0,
      like: false,
    ),
  );

  return list;
}
