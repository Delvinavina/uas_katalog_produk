import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(isLoggedIn: false)) {
    hydrate();
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    // Simulating API call
    await Future.delayed(const Duration(seconds: 2));

    if (event.email == 'admin@example.com' && event.password == 'password123') {
      emit(state.copyWith(
        status: LoginStatus.success,
        isLoggedIn: true,
        email: event.email,
      ));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        isLoggedIn: false,
        errorMessage: 'Invalid email or password',
      ));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      status: LoginStatus.initial,
      isLoggedIn: false,
      email: null,
    ));
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    return LoginState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(LoginState state) {
    return state.toMap();
  }
}
