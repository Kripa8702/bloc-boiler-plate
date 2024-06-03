import 'package:bloc_boiler_plate/features/authentication/repository/auth_repository.dart';
import 'package:bloc_boiler_plate/localizations/app_localization.dart';
import 'package:bloc_boiler_plate/routing/app_routes.dart';
import 'package:bloc_boiler_plate/services/navigator_service.dart';
import 'package:bloc_boiler_plate/theme/app_styles.dart';
import 'package:bloc_boiler_plate/theme/colors.dart';
import 'package:bloc_boiler_plate/utils/initialization_repository.dart';
import 'package:bloc_boiler_plate/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BlocBoilerPlateApp extends StatelessWidget {
  const BlocBoilerPlateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<InitializationRepository>(
              lazy: true,
              create: (context) => InitializationRepository()..init(),
            ),
            RepositoryProvider<AuthRepository>(
              create: (context) => AuthRepository(
                dioClient: context.read<InitializationRepository>().dioClient,
              ),
            ),
          ],
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MaterialApp(
              title: 'Bloc Architecture Demo',
              debugShowCheckedModeBanner: false,
              navigatorKey: NavigatorService.navigatorKey,
              locale: const Locale('en', ''),
              localizationsDelegates: const [
                AppLocalizationDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData(
                  fontFamily: 'Poppins',
                  colorScheme: const ColorScheme.light(
                    primary: primaryColor,
                    secondary: secondaryColor,
                    background: Colors.white,
                  ),
                  useMaterial3: true,
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: TextTheme(
                    bodyLarge: CustomTextStyles.bodyLarge,
                    bodyMedium: CustomTextStyles.bodyMedium,
                    bodySmall: CustomTextStyles.bodySmall,
                    displaySmall: CustomTextStyles.displaySmall,
                    headlineMedium: CustomTextStyles.headlineMedium,
                    labelLarge: CustomTextStyles.labelLarge,
                    titleLarge: CustomTextStyles.titleLarge,
                    titleMedium: CustomTextStyles.titleMedium,
                    titleSmall: CustomTextStyles.titleSmall,
                  )),
              initialRoute: AppRoutes.splashScreen,
              routes: AppRoutes.routes,
            ),
          ),
        );
      },
    );
  }
}
