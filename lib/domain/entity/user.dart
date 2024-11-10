class User {
  final String? email;
  final String? password;
  final bool isLogIn;

  User({required this.email, required this.password, this.isLogIn = false});

   Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'isLogIn': isLogIn,
    };
  }


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String?,
      password: json['password'] as String?,
      isLogIn: json['isLogIn'] as bool? ?? false,
    );
  }
}
