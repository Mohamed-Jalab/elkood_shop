import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../../core/constants.dart';
import '../bloc/register_bloc/register_bloc.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'main_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              child: BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    debugPrint('Success (id: ${state.id})');
                    ToastContext().init(context);
                    Toast.show("Register Successfully",
                        duration: Toast.lengthLong);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                        (route) => false);
                  } else if (state is RegisterFailureState) {
                    ToastContext().init(context);
                    Toast.show(state.message, duration: Toast.lengthLong);
                  }
                },
                builder: (context, state) {
                  RegisterBloc bloc = BlocProvider.of<RegisterBloc>(context);
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
                      const Text('Register',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 30)),
                      SizedBox(height: height * 0.01),
                      const Text('Enter Your Personal Information',
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(height: height * 0.025),
                      const Text('Username',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      SizedBox(height: height * 0.01),
                      CustomTextField(
                        controller: bloc.usernameController,
                        hintText: 'Enter your name',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: height * 0.025),
                      const Text('Email',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      SizedBox(height: height * 0.01),
                      CustomTextField(
                        controller: bloc.emailController,
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: height * 0.025),
                      const Text('Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                      SizedBox(height: height * 0.01),
                      CustomTextField(
                        obscureText: bloc.obscureText,
                        suffix: IconButton(
                          onPressed: () {
                            bloc.add(RegisterVisiblePasswordEvent());
                          },
                          icon: Icon(bloc.obscureText
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded),
                        ),
                        controller: bloc.passwordController,
                        hintText: 'Enter Password',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: height * 0.1),
                      if (state is RegisterLoadingState)
                        const LinearProgressIndicator(color: primaryColor),
                      SizedBox(height: height * 0.01),
                      CustomButton(
                        onTap: () {
                          if (bloc.emailController.text != '' &&
                              bloc.usernameController.text != '' &&
                              bloc.passwordController.text != '') {
                            bloc.add(TryRegisterEvent());
                          }
                        },
                        backColor: primaryColor,
                        title: 'Register',
                        foreColor: Colors.white,
                      ),
                      SizedBox(height: height * 0.05),
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
