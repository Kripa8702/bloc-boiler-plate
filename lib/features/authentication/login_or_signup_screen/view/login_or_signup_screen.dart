import 'package:bloc_boiler_plate/features/widgets/custom_elevated_button.dart';
import 'package:bloc_boiler_plate/routing/app_routes.dart';
import 'package:bloc_boiler_plate/theme/app_styles.dart';
import 'package:bloc_boiler_plate/theme/colors.dart';
import 'package:bloc_boiler_plate/theme/custom_button_style.dart';
import 'package:bloc_boiler_plate/services/navigator_service.dart';
import 'package:bloc_boiler_plate/utils/size_utils.dart';
import 'package:flutter/material.dart';

class LoginOrSignupScreen extends StatelessWidget {
  const LoginOrSignupScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return const LoginOrSignupScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 39.h),
          child: Column(
            children: [
              _buildPageHeader(context),
              SizedBox(height: 150.h),
              Text(
                "Get in through",
                style:
                    CustomTextStyles.titleMedium.copyWith(color: primaryColor),
              ),
              SizedBox(height: 33.h),
              CustomElevatedButton(
                text: "Sign Up",
                buttonTextStyle: CustomTextStyles.titleMedium.copyWith(
                  color: secondaryTextColor,
                  fontSize: 16.fSize,
                ),
                buttonStyle: CustomButtonStyles.fillBlue,
                onPressed: () {
                  // NavigatorService.pushNamed(
                  //   AppRoutes.signupScreen,
                  // );
                },
              ),
              SizedBox(height: 14.h),
              CustomElevatedButton(
                text: "Login",
                buttonStyle: CustomButtonStyles.fillDeepOrange,
                buttonTextStyle: CustomTextStyles.titleMedium.copyWith(
                  color: secondaryTextColor,
                  fontSize: 16.fSize,
                ),
                onPressed: () {
                  NavigatorService.pushNamed(
                    AppRoutes.loginScreen,
                  );
                },
              ),
              SizedBox(height: 5.h)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 208.w,
          child: Text(
            "Welcome to our community",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.displaySmall,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          width: 281.w,
          margin: EdgeInsets.only(right: 29.w),
          child: Text(
            "Our community is ready to help you to join our best platform",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.bodySmall,
          ),
        )
      ],
    );
  }
}
