part of 'register_bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterVisiblePasswordState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final int id;

  RegisterSuccessState({required this.id});
}

class RegisterFailureState extends RegisterState {
  final String message;

  RegisterFailureState({required this.message});
}
