import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_crm/features/users/data/i_auth_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/collection_const.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserFacade)

class IUserImpli implements IUserFacade{
  final FirebaseFirestore firestore;
  final FirebaseAuth fireauth;

  IUserImpli( this.firestore,  this.fireauth);

 @override
Future<Either<MainFailures, String>> addUser({required UserModel usermodel}) async {
  log("Adding started");
  try {
    final id = firestore.collection(Collection.users).doc().id; // Generate a unique ID
    log("Generated ID: $id");
    
    final userRef = firestore.collection(Collection.users).doc(id);
    final user = usermodel.copyWith(id: id);
    log("User reference and model prepared");

    // Log the map to see what is being sent to Firestore
    log("User data to add: ${user.toMap()}");

    await userRef.set(user.toMap());
    log("User added successfully");

    return right("User added");
  } catch (e, stacktrace) {
    log("Error while adding user: $e");
    log("Stacktrace: $stacktrace");
    return left(MainFailures.serverFailures(errormsg: e.toString()));
  }
}


  
}