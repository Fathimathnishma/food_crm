

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_crm/firebase_options.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @preResolve
  Future<FirebaseServices> get firebaseServices =>FirebaseServices.init();
  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

   @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;  // Regist
}


class FirebaseServices {
  static Future<FirebaseServices> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseServices();
  }
}
