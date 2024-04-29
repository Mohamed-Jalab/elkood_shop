import 'package:flutter/material.dart';
import 'package:shop_app/core/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.keyboardType,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffix,
    this.prefix,
    this.onChanged,
  });
  final void Function(String?)? onChanged;
  final TextInputType keyboardType;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: suffix,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: prefix,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFf6F7F9),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }
}
