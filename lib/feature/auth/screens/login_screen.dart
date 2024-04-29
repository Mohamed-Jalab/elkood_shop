import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/feature/auth/screens/main_screen.dart';
import 'package:toast/toast.dart';

import '../../../core/constants.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    ToastContext().init(context);
                    Toast.show("Login Successfully",
                        duration: Toast.lengthLong);
                    debugPrint('Success (token: ${state.token})');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                        (route) => false);
                  } else if (state is LoginFailureState) {
                    ToastContext().init(context);
                    Toast.show(state.message, duration: Toast.lengthLong);
                  }
                },
                builder: (context, state) {
                  LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.03),
                      CustomBackButton(onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }),
                      SizedBox(height: height * 0.05),
                      const Center(
                        child: Text('ELKOOD Shop',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 36,
                                color: primaryColor)),
                      ),
                      SizedBox(height: height * 0.07),
                      const Text('Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 30)),
                      SizedBox(height: height * 0.01),
                      const Text('Login to continue using the app',
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(height: height * 0.025),
                      const Text('Username',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      SizedBox(height: height * 0.01),
                      CustomTextField(
                        controller: bloc.usernameController,
                        hintText: 'Enter your username',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: height * 0.025),
                      const Text('Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      SizedBox(height: height * 0.01),
                      CustomTextField(
                        suffix: IconButton(
                          onPressed: () {
                            bloc.add(LoginVisiblePasswordEvent());
                          },
                          icon: Icon(!bloc.obscureText
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded),
                        ),
                        obscureText: bloc.obscureText,
                        controller: bloc.passwordController,
                        hintText: 'Enter Password',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: height * 0.1),
                      if (state is LoginLoadingState)
                        const LinearProgressIndicator(color: primaryColor),
                      SizedBox(height: height * 0.01),
                      CustomButton(
                        onTap: () {
                          if (bloc.usernameController.text != '' &&
                              bloc.passwordController.text != '') {
                            bloc.add(TryLoginEvent());
                          }
                        },
                        backColor: primaryColor,
                        title: 'Login',
                        foreColor: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
