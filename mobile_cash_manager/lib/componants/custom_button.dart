import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/shared/colors.dart';

class CustomButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget child;
  const CustomButton({super.key, required this.onPressed, required this.child});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(blue),
          foregroundColor: const MaterialStatePropertyAll(Colors.white)),
      child: widget.child,
    );
  }
}
