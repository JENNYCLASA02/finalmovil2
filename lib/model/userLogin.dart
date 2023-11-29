class UserLogin {
  final String message;
  final String status;

  UserLogin({required this.message, required this.status});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      message: json['message'],
      status: json['status'],
    );
  }
}
