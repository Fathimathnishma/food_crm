import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:food_crm/features/home/data/i_home_facade.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';
import 'package:food_crm/features/users/data/model/user_model.dart';
import 'package:food_crm/general/failures/failures.dart';
import 'package:food_crm/general/utils/firebase_collection.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: IHomeFacade)
class IHomeImpli implements IHomeFacade {
  final FirebaseFirestore firebaseFirestore;

  IHomeImpli(this.firebaseFirestore);

  DocumentSnapshot? lastDoc;
  @override
  Future<Either<MainFailures, List<OrderModel>>> fetchTodayOrderList(
      {required String todayDate}) async {
    try {
      final date = DateFormat('dd MMMM yyyy').parse(todayDate);
      final startOfDay =
          Timestamp.fromDate(DateTime(date.year, date.month, date.day));
      final endOfDay = Timestamp.fromDate(
          DateTime(date.year, date.month, date.day, 23, 59, 59, 999));

      log("Fetching orders...");
      final todayOrder = await firebaseFirestore
          .collection(FirebaseCollection.order)
          .where("createdAt", isGreaterThanOrEqualTo: startOfDay)
          .where("createdAt", isLessThanOrEqualTo: endOfDay)
          .orderBy("createdAt", descending: true)
          .get();

      if (todayOrder.docs.isEmpty) {
        log("No orders found.");
      }
      final orders =
          todayOrder.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
      return right(orders);
    } catch (e) {
      log("Error while fetching orders: $e");

      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<UserModel>>> fetchUser() async {
    try {
      final userRef = firebaseFirestore
          .collection(FirebaseCollection.users)
          .orderBy("createdAt", descending: true);

      Query query = userRef.limit(10);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc!);
      }
      final querySnapshot = await query.get();
      final List<UserModel> users = querySnapshot.docs.map((e) {
        return UserModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
      return right(users);
    } catch (e) {
      log("Error while fetching user: $e");
      return left(MainFailures.serverFailures(errormsg: e.toString()));
    }
  }
  
  @override
  Stream<Either<MainFailures, Map<String, num>>> fetchUserCountTotal()  {
  try{
    final generalDocRef =
        firebaseFirestore.collection(FirebaseCollection.general).doc(FirebaseCollection.general);
       return generalDocRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() ?? {};

        final result = {
          'totalAmount': data['totalAmount'] as num? ?? 0,
          'userCount': data['userCount'] as num? ?? 0,
          'generalRef': data['generalRef'] as num? ?? 0,
        };

        return right(result); 
      } else {
        return left(const MainFailures.serverFailures(errormsg: "Document does not exist"));
      }
       });
  }catch (e) {
      log("Error while fetching user: $e");
       return Stream.value(left(MainFailures.serverFailures(errormsg: e.toString())));
    }
}
  }