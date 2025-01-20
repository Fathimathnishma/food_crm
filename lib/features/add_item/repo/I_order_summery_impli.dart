import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/i_order_summery_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: IOrderSummeryFacade)
class IOrderSummeryImpli implements IOrderSummeryFacade{
   final FirebaseFirestore firestore;
  IOrderSummeryImpli(this.firestore);

  @override
  Future<Either<MainFailures, List<UserModel>>> fetchUsers() async {
try {
      final userRef = firestore
          .collection(FirebaseCollection.users)
          .orderBy("createdAt", descending: true);
      final querySnapshot = await userRef.get();
      final List<UserModel> users = querySnapshot.docs.map((e) {
        return UserModel.fromMap(e.data() );
      }).toList();
      return right(users);
    } catch (e) {
      log("Error while fetching user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
}