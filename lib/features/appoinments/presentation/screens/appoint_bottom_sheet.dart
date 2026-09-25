import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import 'package:medico/features/home/data/models/doctor_model.dart';

import '../../data/models/appoinment_model.dart';
import '../cubit/apppointment_cubit.dart';

class AppointmentBottomSheet extends StatefulWidget {
  final DoctorModel doctor;

  const AppointmentBottomSheet({
    super.key,
    required this.doctor,
  });

  @override
  State<AppointmentBottomSheet> createState() =>
      _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState
    extends State<AppointmentBottomSheet> {
  int _selectedDateIndex = 0;
  int? _selectedTimeIndex;

  final List<DateTime> _availableDates = List.generate(
    7,
        (index) => DateTime.now().add(
      Duration(days: index + 1),
    ),
  );

  final List<String> _availableTimes = [
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
  ];

  Future<void> _confirmAppointment() async {
    if (_selectedTimeIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select an available time',
          ),
        ),
      );
      return;
    }

    final selectedDate = _availableDates[_selectedDateIndex];
    final selectedTime = _availableTimes[_selectedTimeIndex!];

    final appointment = AppointmentModel(
      doctor: widget.doctor,
      date:
      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
      time: selectedTime,
      status: 'Upcoming',
    );

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Confirm Appointment',
            style: TextStyle(
              color: AppColors.mainText,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to book this appointment?',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 18),

              Text(
                widget.doctor.name,
                style: TextStyle(
                  color: AppColors.mainText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Text(
                widget.doctor.specialization,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 13,
                ),
              ),

              SizedBox(height: 14),

              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.primary,
                    size: 17,
                  ),
                  SizedBox(width: 7),
                  Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    style: TextStyle(
                      color: AppColors.mainText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: AppColors.primary,
                    size: 17,
                  ),
                  SizedBox(width: 7),
                  Text(
                    selectedTime,
                    style: TextStyle(
                      color: AppColors.mainText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Confirm',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    try {
      final appointmentCubit = context.read<AppointmentCubit>();

      await appointmentCubit.addAppointment(appointment);

      if (!mounted) return;

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Appointment booked successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to book appointment',
          ),
        ),
      );


    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 22),

                _buildDoctorHeader(),

                SizedBox(height: 26),

                Text(
                  'Select Date',
                  style: TextStyle(
                    color: AppColors.mainText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                _buildDates(),

                SizedBox(height: 26),

                Text(
                  'Available Times',
                  style: TextStyle(
                    color: AppColors.mainText,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                _buildTimes(),

                SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _confirmAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm Appointment',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorHeader() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            widget.doctor.imageUrl,
            width: 65,
            height: 65,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 65,
                height: 65,
                color: AppColors.border,
                child: Icon(
                  Icons.person,
                  color: AppColors.secondaryText,
                ),
              );
            },
          ),
        ),

        SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doctor.name,
                style: TextStyle(
                  color: AppColors.mainText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                widget.doctor.specialization,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 17,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '${widget.doctor.rating}',
                    style: TextStyle(
                      color: AppColors.mainText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDates() {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _availableDates.length,
        separatorBuilder: (_, __) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          final date = _availableDates[index];
          final isSelected = _selectedDateIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDateIndex = index;
                _selectedTimeIndex = null;
              });
            },
            child: Container(
              width: 65,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.border,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(date),
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.secondaryText,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.mainText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimes() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
        _availableTimes.length,
            (index) {
          final isSelected = _selectedTimeIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.border,
                ),
              ),
              child: Text(
                _availableTimes[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.white
                      : AppColors.mainText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDayName(DateTime date) {
    const days = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return days[date.weekday - 1];
  }
}