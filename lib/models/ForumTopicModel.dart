class ForumTopicModel {
  String? name;
  String? domain;
  String? title;
  String? postNo;
  String? voicesNo;
  String? freshness;
  bool? isFav;

  ForumTopicModel(
      {this.title,
      this.domain,
      this.freshness,
      this.name,
      this.postNo,
      this.voicesNo,
      this.isFav});
}

List<ForumTopicModel> getTopicsList() {
  List<ForumTopicModel> list = [];

  list.add(ForumTopicModel(
    name: 'Ronald Richards',
    domain: 'Prototype Issues',
    title: 'Devices Resolutions For Prototyping',
    postNo: '125',
    voicesNo: '100',
    freshness: 'Savannah Nguyen',
    isFav: false,
  ));
  list.add(ForumTopicModel(
    name: 'Frank N. Stein',
    domain: 'Market',
    title: 'How To Start Investing In UMarket',
    postNo: '25',
    voicesNo: '50',
    freshness: 'Perry Scope',
    isFav: false,
  ));
  list.add(ForumTopicModel(
    name: 'Frank N. Stein',
    domain: 'Photoshop',
    title: 'GIF On Rendering Images In Photoshop',
    postNo: '125',
    voicesNo: '200',
    freshness: 'Perry Scope',
    isFav: false,
  ));

  list.add(ForumTopicModel(
    name: 'Ronald Richards',
    domain: 'Prototype Issues',
    title: 'Devices Resolutions For Prototyping',
    postNo: '125',
    voicesNo: '100',
    freshness: 'Savannah Nguyen',
    isFav: true,
  ));
  list.add(ForumTopicModel(
    name: 'Frank N. Stein',
    domain: 'Market',
    title: 'How To Start Investing In UMarket',
    postNo: '25',
    voicesNo: '50',
    freshness: 'Perry Scope',
    isFav: true,
  ));
  list.add(ForumTopicModel(
    name: 'Frank N. Stein',
    domain: 'Photoshop',
    title: 'GIF On Rendering Images In Photoshop',
    postNo: '125',
    voicesNo: '200',
    freshness: 'Perry Scope',
    isFav: true,
  ));

  return list;
}
