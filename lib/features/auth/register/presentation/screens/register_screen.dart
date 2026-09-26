import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medico/core/routes/app_routes.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import 'package:medico/core/widgets/text_field.dart';

import '../../data/models/rejester_request_model.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onRegisterPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final registerModel = RegisterRequestModel(
      name: _nameController.text.trim(),
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    context.read<RegisterCubit>().register(
      registerModel,
      _phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
                  (route) => false,
            );
          }

          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Something went wrong'),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == Status.loading;

          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 29, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.mainText,
                            size: 25,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainText,
                        ),
                      ),

                      SizedBox(height: 30),

                      // Full Name
                      AppTextFormField(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // Username
                      AppTextFormField(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        controller: _usernameController,
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Color(0xff66758A),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your username';
                          }

                          if (value.trim().length < 3) {
                            return 'Username must be at least 3 characters';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // Email
                      AppTextFormField(
                        labelText: 'Email Address',
                        hintText: 'you@example.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.secondaryText,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }

                          final emailRegex = RegExp(
                            r'^[A-Za-z0-9._%+-]+@gmail\.com$',
                            caseSensitive: false,
                          );

                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Please enter a valid Gmail address';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // Phone
                      AppTextFormField(
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: AppColors.secondaryText,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          }

                          if (value.length != 11) {
                            return 'Phone number must be 11 digits';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // Password
                      AppTextFormField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        controller: _passwordController,
                        obscureText: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.secondaryText,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_outlined,
                          color: AppColors.secondaryText,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }

                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 30),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            _onRegisterPressed(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3181EA),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                          child: isLoading
                              ? SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                              : Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      // Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: AppColors.mainText,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  }

