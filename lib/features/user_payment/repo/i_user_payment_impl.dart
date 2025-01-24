import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/model/user_dialy_order_model.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserPaymentFacade)
class IUserPaymentRepo implements IUserPaymentFacade {
  final FirebaseFirestore firebaseFirestore;

  IUserPaymentRepo({required this.firebaseFirestore});

  @override
  Future<Either<MainFailures, UserDialyOrderModel?>> fetchUserPayment(
      {required String userId}) async {
    try {
      final userRef =
          firebaseFirestore.collection(FirebaseCollection.users).doc(userId);

      final dailyOrderSnapshot = await userRef
          .collection(FirebaseCollection.dailyOrders)
          .where('createdAt', isEqualTo: Timestamp.now())
          .limit(1)
          .get();

      if (dailyOrderSnapshot.docs.isNotEmpty) {
        final order =
            UserDialyOrderModel.fromMap(dailyOrderSnapshot.docs.first.data());
        log(dailyOrderSnapshot.docs.first.toString());

        return right(order);
      }
      return right(null);
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

//         @override
//     Future<Either<MainFailures, List<dynamic>>> fetchUserDailyOrder({required String userId}) async {
//      try {
//     final userRef = firebaseFirestore.collection(FirebaseCollection.users).doc(userId);

//     final querySnapshot = await userRef.collection(FirebaseCollection.dailyOrders).get();

// List<dynamic>dates=[];
// dates.add(querySnapshot);
//     // final orders = querySnapshot.docs.map((doc) {
//     //   return UserDialyOrderModel.fromMap(doc.data());
//     // }).toList();

//     return Right(dates);
//   } catch (e) {
//     return Left(MainFailures.serverFailures(errormsg: e.toString()));
//   }

   

}




