part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final bool isLoggedIn;
  final String? email;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.isLoggedIn = false,
    this.email,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    bool? isLoggedIn,
    String? email,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  static LoginState fromMap(Map<String, dynamic> map) {
    return LoginState(
      status: LoginStatus.values[map['status'] ?? 0],
      isLoggedIn: map['isLoggedIn'] ?? false,
      email: map['email'],
      errorMessage: map['errorMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status.index,
      'isLoggedIn': isLoggedIn,
      'email': email,
      'errorMessage': errorMessage,
    };
  }

  @override
  List<Object?> get props => [status, isLoggedIn, email, errorMessage];
}
