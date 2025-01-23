
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
          .collection(FirebaseCollection.dailyOrder)
          .where('createdAt', isEqualTo: Timestamp.now())
          .limit(1)
          .get();

      if (dailyOrderSnapshot.docs.isNotEmpty) {
        final order =
            UserDialyOrderModel.fromMap(dailyOrderSnapshot.docs.first.data());

        return right(order);
      }
      return right(null);
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
}


