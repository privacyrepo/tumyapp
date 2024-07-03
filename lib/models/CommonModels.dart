class DrawerModel {
  String? title;
  String? image;

  DrawerModel({this.image, this.title});
}

List<DrawerModel> getDrawerOptions() {
  List<DrawerModel> list = [];

  list.add(
      DrawerModel(image: 'images/tumy/icons/ic_Profile.png', title: 'Profile'));
  list.add(
      DrawerModel(image: 'images/tumy/icons/ic_2User.png', title: 'Friends'));
  // list.add(
  //     DrawerModel(image: 'images/tumy/icons/ic_3User.png', title: 'Groups'));
  // list.add(
  //     DrawerModel(image: 'images/tumy/icons/ic_Image.png', title: 'Gallery'));
  // list.add(
  //     DrawerModel(image: 'images/tumy/icons/ic_Document.png', title: 'Forums'));
  list.add(
      DrawerModel(image: 'images/tumy/icons/ic_Send.png', title: 'Share App'));
  list.add(
      DrawerModel(image: 'images/tumy/icons/ic_Star.png', title: 'Rate Us'));
  list.add(
      DrawerModel(image: 'images/tumy/icons/ic_Logout.png', title: 'Logout'));

  return list;
}
