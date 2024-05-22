import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc_boiler_plate/features/authentication/repository/auth_repository.dart';
import 'package:bloc_boiler_plate/routing/app_routes.dart';
import 'package:bloc_boiler_plate/services/navigator_service.dart';
import 'package:bloc_boiler_plate/services/version_control_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashInitial>(_onInitialize);
  }

  _onInitialize(
    SplashInitial event,
    Emitter<SplashState> emit,
  ) async {
    if (VersionControlService.update != null) {
      await VersionControlService.showUpgradeDialog(
        event.context,
        VersionControlService.update!,
      );
      // return;
    }

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (event.context.read<AuthRepository>().isSignedIn) {
        NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.landingPageScreen,
        );
      } else {
        NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.loginOrSignupScreen,
        );
      }
    });
  }
}
