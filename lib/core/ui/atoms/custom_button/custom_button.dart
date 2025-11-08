import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? icon;
  final String text;
  final IconAlignment? iconAlignment;

  const CustomButton({
    super.key,
    this.onPressed,
    this.icon,
    required this.text,
    this.iconAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      iconAlignment: iconAlignment,
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
