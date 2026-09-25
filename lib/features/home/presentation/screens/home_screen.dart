import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico/core/routes/themes/app_colors.dart';

import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/widgets/home_app_bar.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../../core/widgets/specialization_list.dart';
import '../../../../core/widgets/top_doctor.dart';
import '../../../favourites/presentation/cubit/favourite_cubit.dart';
import '../../../favourites/presentation/cubit/favourite_state.dart';
import '../../data/models/doctor_model.dart';
import '../../data/models/specialization_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedSpecialization = 0;

  final List<SpecializationModel> _specializations = const [
    SpecializationModel(
      title: 'Dentist',
      icon: Icons.medical_services_outlined,
    ),
    SpecializationModel(
      title: 'Cardiologist',
      icon: Icons.favorite_border_rounded,
    ),
    SpecializationModel(
      title: 'Dermatologist',
      icon: Icons.info_outline_rounded,
    ),
    SpecializationModel(title: 'Neurologist', icon: Icons.psychology_outlined),
  ];

  final List<DoctorModel> _doctors = const [
    DoctorModel(
      name: 'Dr. Ahmed Ali',
      specialization: 'Dentist',
      imageUrl: 'https://i.pravatar.cc/150?img=12',
      rating: 4.8,
      yearsOfExperience: 8,
      location: 'Cairo, Egypt',
    ),

    DoctorModel(
      name: 'Dr. Sara Mohamed',
      specialization: 'Cardiologist',
      imageUrl: 'https://i.pravatar.cc/150?img=32',
      rating: 4.7,
      yearsOfExperience: 6,
      location: 'Giza, Egypt',
    ),
    DoctorModel(
      name: 'Dr. Omar Hassan',
      specialization: 'Dermatologist',
      imageUrl: 'https://i.pravatar.cc/150?img=51',
      rating: 4.9,
      yearsOfExperience: 10,
      location: 'Alexandria, Egypt',
    ),
    DoctorModel(
      name: 'Dr. Layla Youssef',
      specialization: 'Neurologist',
      imageUrl: 'https://i.pravatar.cc/150?img=45',
      rating: 4.6,
      yearsOfExperience: 12,
      location: 'Cairo, Egypt',
    ),
    DoctorModel(
      name: 'Dr. Amira Youssef',
      specialization: 'Neurologist',
      imageUrl: 'https://i.pravatar.cc/150?img=45',
      rating: 4.6,
      yearsOfExperience: 12,
      location: 'Cairo, Egypt',
    ),
    DoctorModel(
      name: 'Dr. Mona Youssef',
      specialization: 'Neurologist',
      imageUrl: 'https://i.pravatar.cc/150?img=45',
      rating: 4.6,
      yearsOfExperience: 12,
      location: 'Cairo, Egypt',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),

                HomeAppBarWidget(
                  userName: 'Ebtsam',
                  onNotificationTap: () {},
                ),

                SizedBox(height: 20),

                HomeSearchField(),

                SizedBox(height: 26),

                SpecializationsListWidget(
                  specializations: _specializations,
                  selectedIndex: _selectedSpecialization,
                  onSelected: (index) {
                    setState(() => _selectedSpecialization = index);
                  },
                ),

                SizedBox(height: 26),
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    print('HOME REBUILT: ${state.runtimeType}');

                    final favoriteCubit = context.read<FavoriteCubit>();

                    return TopDoctorsListWidget(
                      doctors: _doctors,
                      isFavorite: favoriteCubit.isFavorite,
                      onFavoriteTap: (doctor) {
                        favoriteCubit.toggleFavorite(doctor);
                      },
                      onBookTap: (doctor) {},
                      onSeeAllTap: () {},
                    );
                  },
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
