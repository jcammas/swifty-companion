class User {
  String imgUrl;
  String login;
  String email;
  int pointCorrec;
  int wallet;
  List cursusUsers;
  List projectUsers;

  User({
    required this.login,
    required this.imgUrl,
    required this.email,
    required this.pointCorrec,
    required this.wallet,
    required this.cursusUsers,
    required this.projectUsers,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        login: json['login'],
        imgUrl: json['image_url'],
        email: json['email'],
        pointCorrec: json['correction_point'],
        wallet: json['wallet'],
        cursusUsers: json['cursus_users'],
        projectUsers: json['projects_users']);
  }
}
