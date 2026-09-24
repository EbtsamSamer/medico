import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import 'package:medico/core/widgets/specialization_chip.dart';

import '../../features/home/data/models/specialization_model.dart';

class SpecializationsListWidget extends StatelessWidget {
  final List<SpecializationModel> specializations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const SpecializationsListWidget({
    super.key,
    required this.specializations,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Specializations',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.mainText,
          ),
        ),
         SizedBox(height: 14),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: specializations.length,
            separatorBuilder: (_, __) =>  SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SpecializationChip(
                specialization: specializations[index],
                isSelected: index == selectedIndex,
                onTap: () => onSelected(index),
              );
            },
          ),
        ),
      ],
    );
  }
}