import 'package:flutter/material.dart';

class SildeRightPageRoute extends PageRouteBuilder {
  final Widget screen;
  SildeRightPageRoute({required this.screen})
      : super(
            pageBuilder: (context, animation1, animation2) => screen,
            transitionsBuilder: (context, animation1, animation2, child) {
              final Animatable<Offset> tween =
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
              // final Animation<Offset> offsetAnimation =
              //     animation1.drive<Offset>(tween);
              final CurvedAnimation curvedAnimation =
                  CurvedAnimation(parent: animation1, curve: Curves.easeInOut);
              // return SlideTransition(position: offsetAnimation, child: child);
              return SlideTransition(
                  position: tween.animate(curvedAnimation), child: child);
            });
}
