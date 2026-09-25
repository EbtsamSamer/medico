import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import 'package:medico/features/home/data/models/doctor_model.dart';

class DoctorCardWidget extends StatelessWidget {
  final DoctorModel doctor;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onBookTap;

  const DoctorCardWidget({
    super.key,
    required this.doctor,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  doctor.imageUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 56,
                    color: AppColors.border,
                    child:  Icon(Icons.person, color: AppColors.secondaryText),
                  ),
                ),
              ),
               SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainText,
                      ),
                    ),
                     SizedBox(height: 2),
                    Text(
                      doctor.specialization,
                      style:  TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                     SizedBox(height: 6),
                    Row(
                      children: [
                         Icon(Icons.star_rounded, color: Color(0xFFFFB020), size: 18),
                         SizedBox(width: 4),
                        Text(
                          '${doctor.rating}',
                          style:  TextStyle(fontSize: 13, color: AppColors.mainText),
                        ),
                         SizedBox(width: 10),
                        Text(
                          '${doctor.yearsOfExperience} yrs exp',
                          style:  TextStyle(fontSize: 13, color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                     SizedBox(height: 4),
                    Row(
                      children: [
                         Icon(Icons.location_on_outlined, color: AppColors.secondaryText, size: 16),
                         SizedBox(width: 2),
                        Text(
                          doctor.location,
                          style:  TextStyle(fontSize: 13, color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onFavoriteTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isFavorite ? Colors.red : Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? Colors.white : Colors.grey,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
           SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: onBookTap,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                padding:  EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon:  Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 18),
              label:  Text(
                'Book Appointment',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}