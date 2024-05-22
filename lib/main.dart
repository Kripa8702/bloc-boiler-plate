import 'package:bloc_boiler_plate/config/flavour_config.dart';
import 'package:bloc_boiler_plate/bloc_boilerplate_app.dart';
import 'package:bloc_boiler_plate/services/app_flavor.dart';
import 'package:bloc_boiler_plate/services/firebase_service.dart';
import 'package:bloc_boiler_plate/services/version_control_service.dart';
import 'package:bloc_boiler_plate/simple_bloc_observer.dart';
import 'package:bloc_boiler_plate/utils/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Uncomment this code if you are using Firebase
  // await Firebase.initializeApp(
  //   name: 'SecondaryApp',
  //   options: FirebaseConfig().firebaseConfig,
  // );

  final package = await PackageInfo.fromPlatform();

  AppFlavor.init(package);

  /// Uncomment this code if you are using Firebase
  // FirebaseService.init();

  await VersionControlService.checkForUpdate();

  Bloc.observer = const SimpleBlocObserver();
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init(),
  ]).then(
    (value) {
      runApp(
        const BlocBoilerPlateApp(),
      );
    },
  );
}
