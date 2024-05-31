import 'package:bloc_boiler_plate/constants/form_values.dart';
import 'package:bloc_boiler_plate/features/authentication/login/bloc/login_bloc.dart';
import 'package:bloc_boiler_plate/features/authentication/repository/auth_repository.dart';
import 'package:bloc_boiler_plate/features/widgets/custom_elevated_button.dart';
import 'package:bloc_boiler_plate/features/widgets/custom_icon_button.dart';
import 'package:bloc_boiler_plate/features/widgets/custom_text_form_field.dart';
import 'package:bloc_boiler_plate/routing/app_routes.dart';
import 'package:bloc_boiler_plate/theme/app_styles.dart';
import 'package:bloc_boiler_plate/theme/colors.dart';
import 'package:bloc_boiler_plate/theme/custom_button_style.dart';
import 'package:bloc_boiler_plate/services/navigator_service.dart';
import 'package:bloc_boiler_plate/utils/size_utils.dart';
import 'package:bloc_boiler_plate/validators/validation_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        authRepo: context.read<AuthRepository>(),
      ),
      child: const LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController =
      TextEditingController(text: FormValues.username);

  TextEditingController passwordController =
      TextEditingController(text: FormValues.password);

  bool onSubmit = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.landingPageScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: onSubmit
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 11.h),
                child: Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 39.h),
                  child: Column(
                    children: [
                      CustomIconButton(
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        padding: EdgeInsets.only(left: 5.w),
                        alignment: Alignment.centerLeft,
                        onTap: () {
                          NavigatorService.goBack();
                        },
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios, size: 16),
                        ),
                      ),
                      _buildPageHeader(context),
                      SizedBox(height: 100.h),
                      CustomTextFormField(
                        controller: emailController,
                        hintText: "Username",
                        textInputType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null ||
                              (!isUsername(value, isRequired: true))) {
                            return "Please enter valid username";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null ||
                              (!isValidPassword(value, isRequired: true))) {
                            return "Please enter valid password";
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 26.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: CustomTextStyles.labelLarge
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(height: 55.h),
                      CustomElevatedButton(
                        text: "Login",
                        buttonStyle: CustomButtonStyles.fillBlue,
                        buttonTextStyle: CustomTextStyles.titleMedium.copyWith(
                          color: secondaryTextColor,
                          fontSize: 16.fSize,
                        ),
                        isLoading: state.status == LoginStatus.loading,
                        onPressed: () {
                          setState(() {
                            onSubmit = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  Login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                      ),
                      SizedBox(height: 28.h),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: Text(
                                "Don’t have an account?",
                                style: CustomTextStyles.labelLarge,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Text(
                                "Sign Up",
                                style: CustomTextStyles.labelLarge.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 221.w,
          margin: EdgeInsets.only(top: 55.h, right: 89.w),
          child: Text(
            "Login",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.displaySmall.copyWith(height: 1.18),
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: 282.w,
          margin: EdgeInsets.only(right: 28.w),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.labelLarge.copyWith(height: 1.67),
          ),
        )
      ],
    );
  }
}
