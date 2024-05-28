import 'dart:io';

import 'package:bloc_boiler_plate/features/widgets/custom_elevated_button.dart';
import 'package:bloc_boiler_plate/services/app_flavor.dart';
import 'package:bloc_boiler_plate/services/firebase_service.dart';
import 'package:bloc_boiler_plate/theme/app_styles.dart';
import 'package:bloc_boiler_plate/theme/colors.dart';
import 'package:bloc_boiler_plate/theme/custom_button_style.dart';
import 'package:bloc_boiler_plate/utils/models/app_update.dart';
import 'package:bloc_boiler_plate/utils/size_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VersionControlService {
  static final firebase = FirebaseFirestore.instance;
  static final staticCollection = FirebaseService.staticCollection;
  static AppUpdate? update;

  static Future<void> checkForUpdate() async {
    // final snapshot =
    //     await firebase.collection(staticCollection).doc('version_info').get();
    // if (!snapshot.exists) return;

    /// Data must be in the following format
    final data = {
      'build_number': 1,
      'version': '1.0.0',
      'change_log': 'Initial Release',
      'force': false,
      'app_url_android':
          'https://play.google.com/store/apps/details?id=com.example.bloc_boiler_plate',
      'app_url_ios': 'https://apps.apple.com/us/app/instagram/id389801252',
    };

    // final data = snapshot.data() as Map<String, dynamic>;
    final buildNumber = data['build_number'] as int;
    final version = data['version'] as String;
    final changeLog = data['change_log'] as String;
    final force = data['force'] as bool;
    final urlAndroid = data['app_url_android'] as String;
    final urlIos = data['app_url_ios'] as String;

    if (buildNumber <= AppFlavor.buildNo) return;

    update = AppUpdate(
      buildNumber: buildNumber,
      version: version,
      changeLog: changeLog,
      force: force,
      urlAndroid: urlAndroid,
      urlIos: urlIos,
    );
  }

  static void openAppStore(AppUpdate update) {
    launchUrlString(Platform.isAndroid ? update.urlAndroid : update.urlIos);
  }

  static Future<void> showUpgradeDialog(
      BuildContext context, AppUpdate update) async {
    return showModalBottomSheet(
      context: context,
      isDismissible: !update.force,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.v),
              Text('App Update Available', style: CustomTextStyles.titleMedium),
              SizedBox(height: 10.v),
              Text('Version: ${update.version}',
                  style: CustomTextStyles.bodyMedium),
              SizedBox(height: 10.v),
              Expanded(
                  child: SingleChildScrollView(
                child: Text('Change Log: ${update.changeLog}',
                    style: CustomTextStyles.bodySmall),
              )),
              SizedBox(height: 20.v),
              CustomElevatedButton(
                text: "Update",
                buttonStyle: CustomButtonStyles.fillBlue,
                buttonTextStyle: CustomTextStyles.titleMedium.copyWith(
                  color: secondaryTextColor,
                  fontSize: 16.fSize,
                ),
                onPressed: () => openAppStore(update),

              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    if (update.force) {
                      exit(0);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                      update.force ? 'No Thanks! Close the App' : 'Dismiss'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
