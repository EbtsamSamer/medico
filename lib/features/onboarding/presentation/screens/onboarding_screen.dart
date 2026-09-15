import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "onboarding_screen";

  @override
  Widget build(BuildContext context) {
    Widget _buildImage(String assetName, [double width = 350]) {
      return Image.asset('assets/images/$assetName', width: width);
    }

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xFFF8FCFD),
      imagePadding: EdgeInsets.symmetric(vertical: 10),
      imageFlex: 3
    );
    return IntroductionScreen(
      showBackButton: true,
      showDoneButton: true,
      showNextButton: true,
      back:Text(
        "Back",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25,
          color: AppColors.primaryDark,
        ),
      ),
      done: Text(
        "Done",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25,
          color: AppColors.primaryDark,
        ),
      ),
      onDone: () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        );
      },
      next: Text(
        "Next",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25,
          color: AppColors.primaryDark,
        ),
      ),


      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, right: 70),
            child: _buildImage('header.png', 300),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          title: "Get the care you deserve",
          body:
              "Book appointments, consult trusted doctors, and manage your health — all "
              "in one place.",
          image: _buildImage("intro1.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Book your appointments easily",
          body:
              "Choose your doctor, pick a convenient time, and manage your visits with ease.",
          image: _buildImage("intro2.png"),
          decoration: pageDecoration,
        ),
      ],
      dotsDecorator:  DotsDecorator(
        activeColor: AppColors.primary,
        size: Size(20.0, 10.0),
        color:  AppColors.primaryDark,
        activeSize: Size(33.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0),

          ),
        ),
      ),
    );
  }
}
