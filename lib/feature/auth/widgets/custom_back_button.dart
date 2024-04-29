import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[200]!, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)))),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ));
  }
}
