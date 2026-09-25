import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import '../cubit/appointment_state.dart';
import '../cubit/apppointment_cubit.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = [
    'Upcoming',
    'Completed',
    'Cancelled',
  ];

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _buildTabs(),
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                if (state is AppointmentLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }

                final appointments =
                    context.read<AppointmentCubit>().appointments;

                final filteredAppointments = appointments.where((appointment) {
                  return appointment.status == _tabs[_selectedTab];
                }).toList();

                if (filteredAppointments.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  itemCount: filteredAppointments.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final appointment = filteredAppointments[index];

                    return _buildAppointmentCard(appointment);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(
          _tabs.length,
              (index) {
            final isSelected = _selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.secondaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(appointment) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  appointment.doctor.imageUrl,
                  width: 58,
                  height: 58,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 58,
                      height: 58,
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
                      appointment.doctor.name,
                      style: TextStyle(
                        color: AppColors.mainText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      appointment.doctor.specialization,
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildInfoItem(
                      Icons.calendar_today_rounded,
                      appointment.date,
                    ),
                    SizedBox(height: 5),
                    _buildInfoItem(
                      Icons.access_time_rounded,
                      appointment.time,
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(appointment.status),
            ],
          ),
          SizedBox(height: 16),
          Divider(
            color: AppColors.border,
            height: 1,
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 17,
                color: AppColors.secondaryText,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  appointment.doctor.location,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                  ),
                ),
              ),
              if (appointment.status == 'Upcoming')
                TextButton(
                  onPressed: () {
                    context
                        .read<AppointmentCubit>()
                        .cancelAppointment(appointment);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
      IconData icon,
      String text,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.primary,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: AppColors.mainText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return AppColors.error;
      case 'Upcoming':
      default:
        return AppColors.primary;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available_rounded,
            size: 55,
            color: AppColors.secondaryText.withOpacity(0.5),
          ),
          SizedBox(height: 14),
          Text(
            'No ${_tabs[_selectedTab].toLowerCase()} appointments',
            style: TextStyle(
              color: AppColors.mainText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Your appointments will appear here',
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}