import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';

import '../../features/home/data/models/doctor_model.dart';
import 'doctor_card.dart';


class TopDoctorsListWidget extends StatelessWidget {
  final List<DoctorModel> doctors;
  final Set<int> favoriteIndexes;
  final ValueChanged<int> onFavoriteTap;
  final ValueChanged<DoctorModel> onBookTap;
  final VoidCallback? onSeeAllTap;

  const TopDoctorsListWidget({
    super.key,
    required this.doctors,
    required this.favoriteIndexes,
    required this.onFavoriteTap,
    required this.onBookTap,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              'Top Doctors',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.mainText,
              ),
            ),
            GestureDetector(
              onTap: onSeeAllTap,
              child:  Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
         SizedBox(height: 14),
        ListView.separated(
          shrinkWrap: true,
          physics:  NeverScrollableScrollPhysics(),
          itemCount: doctors.length,
          separatorBuilder: (_, __) =>  SizedBox(height: 14),
          itemBuilder: (context, index) {
            return DoctorCardWidget(
              doctor: doctors[index],
              isFavorite: favoriteIndexes.contains(index),
              onFavoriteTap: () => onFavoriteTap(index),
              onBookTap: () => onBookTap(doctors[index]),
            );
          },
        ),
      ],
    );
  }
}