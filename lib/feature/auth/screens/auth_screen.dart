import 'package:flutter/material.dart';
import 'package:shop_app/core/animations.dart';
import 'package:shop_app/core/constants.dart';
import 'package:shop_app/core/images.dart';
import 'package:shop_app/feature/auth/widgets/custom_button.dart';

import '../widgets/custom_outlined_button.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height * 0.025),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('ELKOOD Shop',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: primaryColor)),
              ),
              SizedBox(height: height * 0.05),
              const Image(
                image: AssetImage(AppImages.shoppingImage),
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Everthing you need is in one place',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 26)),
                      SizedBox(height: height * 0.02),
                      const Text(
                          'Find your daily essessities at Brand. The world\'s largest fashion e-commerce has arrived in a mobile. shop now!',
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      const Spacer(),
                      CustomButton(
                        onTap: () {
                          Navigator.of(context).push(
                              SildeRightPageRoute(screen: const LoginScreen()));
                        },
                        backColor: primaryColor,
                        title: 'Login',
                        foreColor: Colors.white,
                      ),
                      SizedBox(height: height * .015),
                      CutsomOutlinedButton(
                          onTap: () {
                            Navigator.of(context)
                                .push(SildeRightPageRoute(screen: const RegisterScreen()));
                          },
                          title: 'Register',
                          foreColor: Colors.black12),
                      SizedBox(height: height * 0.03),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
