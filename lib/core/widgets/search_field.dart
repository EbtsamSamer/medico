import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';

class HomeSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const HomeSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      style:  TextStyle(fontSize: 15, color: AppColors.mainText),
      decoration: InputDecoration(
        hintText: 'Search doctors or specialties...',
        hintStyle:  TextStyle(fontSize: 15, color: AppColors.secondaryText),
        prefixIcon:  Icon(Icons.search, color: AppColors.secondaryText),
        filled: true,
        fillColor: AppColors.white,
        contentPadding:  EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:  BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:  BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:  BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}