import 'package:bloc_boiler_plate/constants/array_constants.dart';
import 'package:bloc_boiler_plate/features/bottom_navigation_bar/view/bottom_navigation_screen.dart';
import 'package:bloc_boiler_plate/features/landing_page/bloc/landing_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<LandingPageBloc>(
        create: (context) => LandingPageBloc(),
        child: const LandingPageScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
              child: Center(
                child: bottomNavScreen.elementAt(state.tabIndex),
              ),
            ),
            bottomNavigationBar: BottomNavigationScreen(
              tabIndex: state.tabIndex,
              onTabChange: (index) {
                BlocProvider.of<LandingPageBloc>(context).add(
                  TabChange(tabIndex: index),
                );
              },
            ));
      },
    );
  }
}
