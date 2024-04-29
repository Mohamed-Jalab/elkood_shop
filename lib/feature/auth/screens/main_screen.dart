import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_app/feature/auth/screens/cart_screen.dart';
import 'package:shop_app/feature/auth/screens/home_screen.dart';
import 'package:shop_app/feature/auth/screens/profile_screen.dart';

import '../../../core/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: primaryColor,
            title: const Text('ELKOOD Shop',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.white)),
          ),
          body: SizedBox(
              width: width,
              height: height,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: const [
                  HomeScreen(),
                  CartScreen(),
                  ProfileScreen(),
                ],
              )),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 10,
                    color: Colors.black38),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: GNav(
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
                controller.animateToPage(index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              },
              backgroundColor: Colors.white,
              color: Colors.black45,
              activeColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              tabBackgroundColor: primaryColor.withOpacity(0.1),
              tabs: const [
                GButton(icon: Icons.home_outlined, text: 'Home', gap: 8),
                GButton(
                    icon: Icons.shopping_cart_outlined, text: 'Cart', gap: 8),
                GButton(
                    icon: Icons.person_outline_rounded,
                    text: 'Profile',
                    gap: 8),
              ],
            ),
          )),
    );
  }
}
