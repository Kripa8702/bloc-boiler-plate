class AppUpdate {
  final int buildNumber;
  final String version;
  final String changeLog;
  final bool force;
  final String urlAndroid;
  final String urlIos;

  AppUpdate({
    required this.buildNumber,
    required this.version,
    required this.changeLog,
    required this.force,
    required this.urlAndroid,
    required this.urlIos,
  });
}
