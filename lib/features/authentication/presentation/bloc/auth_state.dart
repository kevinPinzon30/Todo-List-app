part of 'auth_bloc.dart';

class AuthState {
  final String email;
  final String password;

  const AuthState({
    this.email = 'kevin.alexander@pinzon.com',
    this.password = 'Test123@',
  });

  AuthState copyWith({
    String? email,
    String? password,
  }) =>
      AuthState(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object> get props =>
      [
        email,
        password,
      ];
}

class Initial extends AuthState {}

class Loading extends AuthState {}

class SignInSuccessful extends AuthState {
  const SignInSuccessful();

  @override
  List<Object> get props => [];
}

class LogOutSuccessful extends AuthState {
  const LogOutSuccessful();

  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String? message;
  final String? code;

  const AuthError({
    this.message = '',
    this.code = '',
  });

  @override
  List<Object> get props => [];
}
