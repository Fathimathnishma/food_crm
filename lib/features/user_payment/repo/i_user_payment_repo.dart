import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/user_payment/data/i_user_payment_facade.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';

class IUserPaymentRepo implements IUserPaymentFacade {
  final FirebaseFirestore firebaseFirestore;
  IUserPaymentRepo({required this.firebaseFirestore});
  @override
  Future<Either<MainFailures, List<Map<String, dynamic>>>> fetchUserPayment(
      {required String userId}) async {
    try {
      final userRef =
          firebaseFirestore.collection(FirebaseCollection.users).doc(userId);

      final dailyOrderSnapshot = await userRef.collection('dailyOrder').get();

      final dailyOrders =
          dailyOrderSnapshot.docs.map((order) => order.data()).toList();

      return right(dailyOrders);
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
}
