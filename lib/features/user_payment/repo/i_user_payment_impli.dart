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

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  @override
  Future<Either<MainFailures, List<OrderDailyReportModel>>> fetchUserPayment({
    required String userId,
  }) async {
    try {
      final userRef =
          firebaseFirestore.collection(FirebaseCollection.users).doc(userId);
      Query query = userRef
          .collection(FirebaseCollection.dailyOrders)
          .orderBy("createdAt", descending: true);

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

  @override
  Future<Either<MainFailures, Unit>> makePayment({required num paidAmount}) async {
    try {
      final generalRef = firebaseFirestore
          .collection(FirebaseCollection.general)
          .doc(FirebaseCollection.general);
      final userSnapshot =
          await firebaseFirestore.collection(FirebaseCollection.users).get();
      final batch = firebaseFirestore.batch();
      for (final userDoc in userSnapshot.docs) {
        final userRef = userDoc.reference;
        batch.update(userRef, {"monthlyTotal": 0});
      }
       batch.update(generalRef,{"depositAmount": FieldValue.increment(paidAmount)} );
      batch.update(generalRef, {"totalAmount": 0});
      await batch.commit();
      return right(unit);
    } catch (e) {
      log("Error during batch commit: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<UserModel>>> fetchUser() async {
    try {
      final userRef = firebaseFirestore
          .collection(FirebaseCollection.users)
          .orderBy("createdAt", descending: true);

      final querySnapshot = await userRef.get();
      final List<UserModel> users = querySnapshot.docs.map((e) {
        return UserModel.fromMap(e.data());
      }).toList();
      return right(users);
    } catch (e) {
      log("Error while fetching user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  
}
