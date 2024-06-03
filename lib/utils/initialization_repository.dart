import 'dart:developer';

import 'package:bloc_boiler_plate/utils/dio_client.dart';

class InitializationRepository {
  late DioClient dioClient;


  Future<void> init() async {
    dioClient = DioClient();
    log("::::::::::::::::::::: DioClient Initialized :::::::::::::::::::::");
  }
}
