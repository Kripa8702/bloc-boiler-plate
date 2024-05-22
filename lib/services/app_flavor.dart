import 'package:package_info_plus/package_info_plus.dart';

enum Env { stage, prod, dev }

Map<Env, String> apiBaseUrls = {
  Env.dev: "https://dummyjson.com", //Replace with your Development API URL
  Env.prod: "https://dummyjson.com", //Replace with your Production API URL
  Env.stage: "https://dummyjson.com" //Replace with your Staging API URL
};

//Replace with your app names
Map<Env, String> appNames = {
  Env.dev: "Dev",
  Env.prod: "Prod",
  Env.stage: "Stage"
};

class AppFlavor {
  static late String appName;
  static late String apiBaseUrl;
  static late Env env;


  //
  static late int buildNo;
  static String? packageName;
  static String? versionName;
  static String? buildNumber;

  static void init(PackageInfo package) {
    buildNo = int.parse(
      package.buildNumber.replaceAll(RegExp("[a-z]"), ""),
    );
    packageName = package.packageName;
    versionName = package.version;
    buildNumber = package.buildNumber;

    /// Set the environment
    env = Env.dev;
    appName = appNames[env]!;
    apiBaseUrl = apiBaseUrls[env]!;
  }
}
