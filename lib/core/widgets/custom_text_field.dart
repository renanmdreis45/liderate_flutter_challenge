import 'package:flutter/material.dart';
import 'package:liderate_flutter_challenge/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.border),
        filled: true,
        fillColor: AppColors.textFieldBackground,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      style: const TextStyle(color: AppColors.textPrimary),
    );
  }
}
