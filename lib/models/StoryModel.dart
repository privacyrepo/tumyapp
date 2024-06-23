class StoryModel {
  String? name;
  String? profileImage;
  List<String>? storyImages;
  String? time;
  bool? like;

  StoryModel(
      {this.name, this.profileImage, this.storyImages, this.time, this.like});
}

List<StoryModel> getStories() {
  List<StoryModel> list = [];

  list.add(StoryModel(
      name: 'Iana',
      profileImage: 'images/tumy/faces/face_1.png',
      time: '4m',
      like: false));
  list.add(StoryModel(
      name: 'Allie',
      profileImage: 'images/tumy/faces/face_2.png',
      time: '4m',
      like: false));
  list.add(StoryModel(
      name: 'Manny',
      profileImage: 'images/tumy/faces/face_3.png',
      time: '4m',
      like: false));
  list.add(StoryModel(
      name: 'Isabelle',
      profileImage: 'images/tumy/faces/face_4.png',
      time: '4m',
      like: false));
  list.add(StoryModel(
      name: 'Jenny Wilson',
      profileImage: 'images/tumy/faces/face_5.png',
      time: '4m',
      like: false));

  return list;
}
