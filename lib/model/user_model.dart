class UserModel {
  String? email;
  String? image;
  int? theme;
  String? type;
  String? userId;

  UserModel({this.email, this.image, this.theme, this.type, this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    image = json['image'];
    theme = json['theme'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['image'] = this.image;
    data['theme'] = this.theme;
    data['type'] = this.type;
    data['userId'] = this.userId;
    return data;
  }
}
