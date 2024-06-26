import 'package:bloc_boiler_plate/constants/assets_constants.dart';
import 'package:bloc_boiler_plate/features/splash/bloc/splash_bloc.dart';
import 'package:bloc_boiler_plate/features/widgets/custom_image_view.dart';
import 'package:bloc_boiler_plate/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc()
        ..add(
          SplashInitial(context),
        ),
      child: const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1.h),
                  CustomImageView(
                    imagePath: appLogo,
                    height: 325.h,
                    width: 238.w,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
