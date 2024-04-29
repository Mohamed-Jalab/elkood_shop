part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginVisiblePasswordEvent extends LoginEvent {}

class TryLoginEvent extends LoginEvent {}
