import 'package:flutter/material.dart';

class CutsomOutlinedButton extends StatelessWidget {
  const CutsomOutlinedButton({
    super.key,
    required this.title,
    required this.foreColor, required this.onTap,
  });
  final String title;
  final Color foreColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * .07,
      child: OutlinedButton(
        onPressed: onTap,
        style: ButtonStyle(overlayColor: MaterialStatePropertyAll(foreColor)),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
