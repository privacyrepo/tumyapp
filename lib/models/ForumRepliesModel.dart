class ForumRepliesModel {
  String? name;
  String? date;
  String? hashTagNo;
  String? subTitle;
  String? description;
  String? profileImage;
  bool? isOfficial;

  ForumRepliesModel(
      {this.date,
      this.hashTagNo,
      this.subTitle,
      this.name,
      this.description,
      this.profileImage,
      this.isOfficial});
}

List<ForumRepliesModel> getRepliesList() {
  List<ForumRepliesModel> list = [];

  list.add(ForumRepliesModel(
    name: 'Mal Nurrisht',
    date: '25 Feb, 2022 at 05:30 AM',
    hashTagNo: '123',
    subTitle: 'Public Group',
    description:
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit...',
    profileImage: 'images/tumy/faces/face_1.png',
  ));
  list.add(ForumRepliesModel(
    name: 'Mal Nurrisht',
    date: '25 Feb, 2022 at 05:30 AM',
    hashTagNo: '123',
    subTitle: 'Public Group',
    description:
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit...',
    profileImage: 'images/tumy/faces/face_2.png',
  ));

  list.add(ForumRepliesModel(
    name: 'Mal Nurrisht',
    date: '25 Feb, 2022 at 05:30 AM',
    hashTagNo: '123',
    subTitle: 'Public Group',
    description:
        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit...',
    profileImage: 'images/tumy/faces/face_3.png',
  ));

  return list;
}
