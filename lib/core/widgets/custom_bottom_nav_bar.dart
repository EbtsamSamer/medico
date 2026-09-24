import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';

class CustomBottomNavItem {
  final IconData icon;
  final String label;

  const CustomBottomNavItem({required this.icon, required this.label});
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CustomBottomNavItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = const [
      CustomBottomNavItem(icon: Icons.home_rounded, label: 'Home'),
      CustomBottomNavItem(icon: Icons.favorite_border_rounded, label: 'Favorites'),
      CustomBottomNavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset:  Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final bool isSelected = index == currentIndex;
          final item = items[index];
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  color: isSelected ? AppColors.primary : AppColors.secondaryText,
                ),
                 SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? AppColors.primary : AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}