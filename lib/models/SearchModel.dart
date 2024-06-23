class SearchModel {
  String? name;
  String? profileImage;
  String? subTitle;
  bool? isOfficialAccount;
  bool? doSend;

  SearchModel(
      {this.name,
      this.profileImage,
      this.subTitle,
      this.isOfficialAccount,
      this.doSend});
}

List<SearchModel> getRecentList() {
  List<SearchModel> list = [];

  list.add(SearchModel(
      name: 'Jane_ui ux ',
      profileImage: 'images/tumy/faces/face_1.png',
      subTitle: '@Jane_Cooper',
      isOfficialAccount: true));
  list.add(SearchModel(
      name: 'Anne T. Kwayted',
      profileImage: 'images/tumy/faces/face_2.png',
      subTitle: '😈Anne Attack😇',
      isOfficialAccount: false));
  list.add(SearchModel(
      name: 'Tim Midsaylesman',
      profileImage: 'images/tumy/faces/face_3.png',
      subTitle: 'Tim_mid',
      isOfficialAccount: false));
  list.add(SearchModel(
      name: 'Hope Furaletter',
      profileImage: 'images/tumy/faces/face_4.png',
      subTitle: 'Hope✌ Furaletter_12',
      isOfficialAccount: true));
  list.add(SearchModel(
      name: 'Cherry Blossom',
      profileImage: 'images/tumy/faces/face_5.png',
      subTitle: 'Cherryblossom_',
      isOfficialAccount: false));

  return list;
}

List<SearchModel> getSharePostList() {
  List<SearchModel> list = [];

  list.add(SearchModel(
      name: 'Jane_ui ux ',
      profileImage: 'images/tumy/faces/face_1.png',
      isOfficialAccount: true,
      doSend: false));
  list.add(SearchModel(
      name: 'Anne T. Kwayted',
      profileImage: 'images/tumy/faces/face_2.png',
      isOfficialAccount: false,
      doSend: false));
  list.add(SearchModel(
      name: 'Tim Midsaylesman',
      profileImage: 'images/tumy/faces/face_3.png',
      isOfficialAccount: false,
      doSend: false));
  list.add(SearchModel(
      name: 'Hope Furaletter',
      profileImage: 'images/tumy/faces/face_4.png',
      isOfficialAccount: true,
      doSend: false));
  list.add(SearchModel(
      name: 'Cherry Blossom',
      profileImage: 'images/tumy/faces/face_5.png',
      isOfficialAccount: false,
      doSend: false));

  return list;
}
