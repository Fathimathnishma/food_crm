import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';
import 'package:food_crm/features/user_payment/data/model/user_payment_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserPaymentFacade)
class IUserPaymentRepo implements IUserPaymentFacade {
  final FirebaseFirestore firebaseFirestore;

  IUserPaymentRepo({required this.firebaseFirestore});

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  @override
  Future<Either<MainFailures, List<OrderDailyReportModel>>> fetchUserPayment({
    required String userId,
  }) async {
    try {
      final userRef =
          firebaseFirestore.collection(FirebaseCollection.users).doc(userId);
      Query query = userRef.collection(FirebaseCollection.dailyOrders);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.limit(10).get();

      if (querySnapshot.docs.length < 10) {
        noMoreData = true;
      } else {
        lastDocument = querySnapshot.docs.last;
      }

      final newList = querySnapshot.docs
          .map(
            (daily) => OrderDailyReportModel.fromMap(
                daily.data() as Map<String, dynamic>),
          )
          .toList();

      log("Successfully parsed ${newList.length} OrderDailyReportModel objects");
      return right(newList);
    } catch (e) {
      log(
        "Error fetching user payment data: $e",
      );
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
}
