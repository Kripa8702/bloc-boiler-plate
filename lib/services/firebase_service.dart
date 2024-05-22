import 'package:bloc_boiler_plate/constants/firebase_collections.dart';
import 'package:bloc_boiler_plate/services/app_flavor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static late String usersCollection;
  static late String venuesCollection;
  static late String passesCollection;
  static late String chatCollection;
  static late String flagCollection;
  static late String feedbacksCollection;
  static late String staticCollection;

  static void init() {
    if (AppFlavor.env == Env.stage) {
      usersCollection = FirebaseCollections.usersStage;
    }
    if (AppFlavor.env == Env.dev) {
      usersCollection = FirebaseCollections.usersDevelopment;
    } else if (AppFlavor.env == Env.dev) {
      usersCollection = FirebaseCollections.usersProd;
    }
      staticCollection = FirebaseCollections.statics;
  }

  static Exception fireException(FirebaseAuthException e) {
    switch (e.code) {
      case "wrong-password":
        throw Exception("Invalid password or email address. Please Try again!");
      case "user-not-found":
        throw Exception(
            "Account not found against this email address, please sign up!");
      case "invalid-email":
        throw Exception("Invalid password or email address. Please Try again!");
      case "account-exists-with-different-credential":
        throw Exception(
            "Account already logged in via social login. Please try alternative way.");
      default:
        throw Exception(
          e.message,
        );
    }
  }
}
