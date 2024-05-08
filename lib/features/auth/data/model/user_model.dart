class UserModel {
  final String id;
  final String userName;
  final String email;
  final String accessToken;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['name'],
      email: json['email'],
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': userName,
      'email': email,
      'access_token': accessToken,
    };
  }
}
