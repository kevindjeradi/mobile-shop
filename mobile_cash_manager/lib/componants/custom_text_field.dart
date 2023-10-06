import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/shared/colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType type;
  final bool password;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.type,
      this.password = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: 1,
      keyboardType: widget.type,
      obscureText: widget.password,
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          hintText: widget.label,
          filled: true,
          fillColor: inputFill),
    );
  }
}
