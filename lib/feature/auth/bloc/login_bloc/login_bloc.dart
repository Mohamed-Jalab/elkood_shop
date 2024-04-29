import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../injection.dart' as di;
import 'package:shop_app/core/constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginVisiblePasswordEvent) {
        obscureText = !obscureText;
        emit(LoginVisiblePasswordState());
      }
      if (event is TryLoginEvent) {
        try {
  emit(LoginLoadingState());
  String url = '$baseUrl$login';
  debugPrint('Url: $url');
  Map<String, dynamic> json = {
    "username": usernameController.text,
    "password": passwordController.text,
  };
  http.Response res = await http.post(Uri.parse(url), body: json);
  if (res.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(res.body);
    emit(LoginSuccessState(token: jsonData['token']));
    di.sl<SharedPreferences>().setString(userData, jsonEncode(json));
    di.sl<SharedPreferences>().setBool(isLogin, true);
  } else {
    debugPrint('Login Failed');
    emit(LoginFailureState(
        message: 'username or password are not correct'));
  }
} catch (e) {
  debugPrint('Login Failed');
          emit(LoginFailureState(
              message: 'Check your Internet connection'));
}
      }
    });
  }
}
