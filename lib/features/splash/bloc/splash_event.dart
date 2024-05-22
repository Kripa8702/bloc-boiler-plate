part of 'splash_bloc.dart';

class SplashEvent {}

class SplashInitial extends SplashEvent {
  BuildContext context;

  SplashInitial(this.context);
}
