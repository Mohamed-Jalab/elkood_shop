import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../injection.dart' as di;

import '../../../../core/constants.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  bool obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterVisiblePasswordEvent) {
        obscureText = !obscureText;
        emit(RegisterVisiblePasswordState());
      }
      if(event is TryRegisterEvent) {
        try {
  emit(RegisterLoadingState());
  String url = '$baseUrl$register';
  debugPrint('Url: $url');
  Map<String, dynamic> json ={
    "username": usernameController.text,
    "email": emailController.text,
    "password": passwordController.text
  };
  http.Response res = await http.post(Uri.parse(url), body: json);
  if (res.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(res.body);
    emit(RegisterSuccessState(id: jsonData['id']));
    di.sl<SharedPreferences>().setString(userData, jsonEncode(json));
    di.sl<SharedPreferences>().setBool(isLogin, true);
  } else {
    debugPrint('Login Failed');
    emit(RegisterFailureState(
        message: 'username or password are not correct'));
  }
} catch (e) {
  debugPrint('Login Failed');
          emit(RegisterFailureState(message: 'Check your Internet connection'));
}
      }
    });
  }
}
