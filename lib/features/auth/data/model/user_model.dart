class UserModel {
  final int id;
  final String userName;
  final String email;
  final dynamic token;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'email': email,
      'token': token,
    };
  }
}
