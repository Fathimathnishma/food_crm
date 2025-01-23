import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';
import 'package:food_crm/features/user_payment/data/model/user_payment_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserPaymentFacade)
class IUserPaymentRepo implements IUserPaymentFacade {
  final FirebaseFirestore firebaseFirestore;

  IUserPaymentRepo({required this.firebaseFirestore});



  @override
  Future<Either<MainFailures, List<OrderDailyReportModel>>> fetchUserPayment({
    required String userId,
  }) async {
    try {
      final userRef = firebaseFirestore.collection(FirebaseCollection.users).doc(userId);
      final dailyOrderSnapshot = await userRef.collection(FirebaseCollection.dailyOrders).get();
     final List<OrderDailyReportModel> userItem = dailyOrderSnapshot.docs
    .map((doc) => OrderDailyReportModel.fromMap(doc.data()))
    .toList();

      log("Successfully parsed ${userItem.length} OrderDailyReportModel objects");
      return right(userItem);
    } catch (e) {
      log("Error fetching user payment data: $e", );
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  
}
