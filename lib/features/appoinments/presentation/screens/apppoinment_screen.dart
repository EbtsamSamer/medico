import 'package:flutter/material.dart';
import 'package:medico/core/routes/themes/app_colors.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Appointments',
          style: TextStyle(
            color: AppColors.mainText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'No appointments yet',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}