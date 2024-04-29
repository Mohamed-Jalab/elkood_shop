part of 'register_bloc.dart';

abstract class RegisterEvent{}

class RegisterVisiblePasswordEvent extends RegisterEvent {}

class TryRegisterEvent extends RegisterEvent {}
