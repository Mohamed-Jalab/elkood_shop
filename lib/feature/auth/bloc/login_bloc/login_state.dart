part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginVisiblePasswordState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String token;

  LoginSuccessState({required this.token});
}

class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState({required this.message});
}
