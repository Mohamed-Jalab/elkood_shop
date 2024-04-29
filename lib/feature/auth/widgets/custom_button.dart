import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.foreColor,
    required this.backColor,
    required this.title,
    required this.onTap,
    this.currentWidth,
  });
  final Color foreColor, backColor;
  final String title;
  final void Function() onTap;
  final double? currentWidth;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: height * 0.07,
        width: currentWidth ?? width,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            foregroundColor: foreColor,
            backgroundColor: backColor,
          ),
          child: Text(title, style: TextStyle(fontSize: 15, color: foreColor)),
        ));
  }
}
