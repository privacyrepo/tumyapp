class UserModel {
  String? id;
  String? name;
  String? profileImage;
  String? bio;
  String? email;
  String? phone;
  List<String>? friends;
  List<String>? followers;
  List<String>? following;

  UserModel({
    this.id,
    this.name,
    this.profileImage,
    this.bio,
    this.email,
    this.phone,
    this.friends,
    this.followers,
    this.following,
  });
}
