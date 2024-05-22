/// This is a demo usage of the localization package

import 'package:bloc_boiler_plate/localizations/app_localization.dart';
import 'package:bloc_boiler_plate/theme/app_styles.dart';
import 'package:flutter/material.dart';

class DemoUsage extends StatelessWidget {
  const DemoUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "lbl_username".tr,
      style: CustomTextStyles.labelLarge.copyWith(
        decoration: TextDecoration.underline,
      ),
    );
  }
}
