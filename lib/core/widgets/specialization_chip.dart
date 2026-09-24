import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import 'package:medico/features/home/data/models/specialization_model.dart';

class SpecializationChip extends StatelessWidget {
  final SpecializationModel specialization;
  final bool isSelected;
  final VoidCallback onTap;

  const SpecializationChip({
    super.key,
    required this.specialization,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 200),
        padding:  EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              specialization.icon,
              color: isSelected ? AppColors.white : AppColors.primary,
              size: 22,
            ),
             SizedBox(height: 8),
            Text(
              specialization.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.mainText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}