import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';

class HomeAppBarWidget extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;
  final bool hasNotification;

  const HomeAppBarWidget({
    super.key,
    required this.userName,
    this.onNotificationTap,
    this.hasNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Good Morning, $userName',
                      style:  TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainText,
                      ),
                    ),
                  ),
                   SizedBox(width: 6),
                   Text('👋', style: TextStyle(fontSize: 20)),
                ],
              ),
               SizedBox(height: 6),
               Text(
                'Find the right doctor for your needs.',
                style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onNotificationTap,
          child: Container(
            padding:  EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                 Icon(Icons.notifications_none_rounded, color: AppColors.primary),
                if (hasNotification)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration:  BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}