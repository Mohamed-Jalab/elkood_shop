import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/constants.dart';
import 'package:shop_app/injection.dart' as di;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String data = di.sl<SharedPreferences>().getString(userData) ??
        '{"username": "null","password": "null"}';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(children: [
            SizedBox(height: height * 0.02),
            Container(
              width: width * 0.5,
              height: width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.25)),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/avatar.png'))),
            ),
            SizedBox(height: height * 0.05),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 2), blurRadius: 5, color: Colors.grey),
                ],
              ),
              child: Column(
                children: [
                  CustomListTile(
                      title: 'Username: ${jsonDecode(data)["username"]}',
                      icon: Icons.person_outline_rounded),
                  const CustomDivider(),
                  const CustomListTile(
                      title: 'Phone: +963 954 802 408',
                      icon: Icons.phone_outlined),
                  const CustomDivider(),
                  CustomListTile(
                      title: 'Password: ${jsonDecode(data)["password"]}',
                      icon: Icons.password),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      leading: Icon(icon),
      title: Text(title),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: Divider(),
    );
  }
}
