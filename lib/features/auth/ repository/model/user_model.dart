class UserModel {
  final int id;
  final String userName;
  final String email;
  final dynamic token;
  final dynamic premium;

  UserModel(
      {required this.id,
      required this.userName,
      required this.email,
      required this.token,
      required this.premium});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['username'],
      email: json['email'],
      token: json['token'],
      premium: json['premium'],
    );
  }
}
