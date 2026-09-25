import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';

import '../../features/home/data/models/doctor_model.dart';
import 'doctor_card.dart';


class TopDoctorsListWidget extends StatelessWidget {
  final List<DoctorModel> doctors;
  final bool Function(DoctorModel doctor) isFavorite;
  final ValueChanged<DoctorModel> onFavoriteTap;
  final ValueChanged<DoctorModel> onBookTap;
  final VoidCallback? onSeeAllTap;

  const TopDoctorsListWidget({
    super.key,
    required this.doctors,
    required this.isFavorite,
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
              child: Text(
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
        Column(
          children: List.generate(
            doctors.length,
                (index) {
              final doctor = doctors[index];
              final favorite = isFavorite(doctor);

              print('${doctor.name} => isFavorite: $favorite');

              return Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: DoctorCardWidget(
                  doctor: doctor,
                  isFavorite: favorite,
                  onFavoriteTap: () => onFavoriteTap(doctor),
                  onBookTap: () => onBookTap(doctor),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}