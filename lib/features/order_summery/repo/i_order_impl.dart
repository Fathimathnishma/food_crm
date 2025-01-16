import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/order_summery/data/i_order_summary_facade.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: IOrderSummaryFacade)
class IOrderImpl implements IOrderSummaryFacade {
  final FirebaseFirestore firebaseFirestore;
  IOrderImpl({required this.firebaseFirestore});
  @override
  Future<Either<MainFailures, List<UserModel>>> fetchUsers() async {
    try {
      Query query = firebaseFirestore
          .collection(FirebaseCollection.users)
          .orderBy('createdAt', descending: true);

      QuerySnapshot querySnapshot = await query.get();

      final newList = querySnapshot.docs
          .map((user) => UserModel.fromMap(user.data() as Map<String, dynamic>))
          .toList();
      return right(newList);
    } catch (e) {
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
}
