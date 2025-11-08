import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hint;
  final String? errorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hint,
    this.errorText,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.onTap,
    this.controller,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final borderColor = colors.outline;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(8));

    return TextFormField(
      controller: controller,
      onChanged: (value) => onChanged?.call(value),
      validator: (value) => validator?.call(value),
      decoration: InputDecoration(
        enabledBorder: border.copyWith(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        isDense: true,
        labelText: labelText,
        hintText: hint,
        focusColor: colors.primary,
        prefixIcon: prefixIcon,
        errorText: errorText,
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
      ),
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}
