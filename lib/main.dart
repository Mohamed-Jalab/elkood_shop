import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/constants.dart';
import 'package:shop_app/feature/auth/bloc/login_bloc/login_bloc.dart';
import 'package:shop_app/feature/auth/bloc/register_bloc/register_bloc.dart';
import 'package:shop_app/feature/auth/screens/main_screen.dart';

import 'feature/auth/screens/auth_screen.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  islog = sl<SharedPreferences>().getBool(isLogin) ?? false;
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LoginBloc()),
    BlocProvider(create: (context) => RegisterBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: islog ? const MainScreen() : const AuthScreen(),
    );
  }
}
